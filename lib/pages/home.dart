import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safetybuddy/controller/bluetoothController.dart';
import 'package:safetybuddy/pages/account_page.dart';
import 'package:safetybuddy/pages/danger_info.dart';
import 'package:safetybuddy/service/auth_service.dart';
import 'package:safetybuddy/service/notification_service.dart';
import 'dart:async';
//import 'package:location/location.dart';
import '../service/danger_service.dart';
import 'danger_menu.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  final bool stopTimer;
  const Home({super.key, required this.stopTimer});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService authService = Get.put(AuthService());
  final BleController bleController = Get.put(BleController());
  static const LatLng defaultLocation = LatLng(46.163765, 24.351249);
  late GoogleMapController _mapController;
  DangerService service = DangerService();

  Set<Marker> _markers = {};
  Set<Marker> _addedMarkers = {};
  Set<Polygon> _polygons = {};

  Timer? _timer;
  bool _isMenuOpen = false;
  bool _enableLatLngCapture = false;
  List<LatLng> _capturedCoordinates = [];

  bool stopTimer = false;

  @override
  void initState() {
    super.initState();
    //_dangerRefresh();
  }

  void _dangerAndPositionRefresh() {
    _loadDangers();
    var device = bleController.connectedDevice;
    if (!stopTimer) {
      _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
        _loadDangers(); //refreshes dangers on map
        checkLocationStatus(getUserLocation());
      });
    }
  }

  Future<void> _loadDangers() async {
    List<dynamic> dangers = await service.fetchDangers();

    Set<Marker> markers = {};
    Set<Polygon> polygons = {};
    for (var danger in dangers) {
      if (danger['type'] != 'Italian city') {
        dynamic dangerLocation = danger["dangerLocation"];
        markers.add(
          Marker(
            markerId: MarkerId(danger['id'].toString()),
            position: LatLng(dangerLocation["lat"], dangerLocation["lng"]),
            infoWindow: InfoWindow(
              title: danger['type'],
              snippet: danger['description'],
            ),
          ),
        );
      }

      if (danger['type'] == 'Italian city') {
        List<dynamic> rectanglePointJson = danger["rectanglePoints"];
        List<LatLng> rectanglePoints = [];
        for (int i = 0; i <= 3; i++) {
          dynamic rectanglePoint = rectanglePointJson[i];
          rectanglePoints
              .add(LatLng(rectanglePoint["lat"], rectanglePoint['lng']));
        }
        polygons.add(
          Polygon(
            polygonId: PolygonId('polygon_${danger['id']}'),
            points: rectanglePoints,
            strokeColor: Colors.red,
            strokeWidth: 3,
            fillColor: Colors.red.withOpacity(0.2),
          ),
        );
      }
    }
    print(markers.length);
    setState(() {
      _markers = markers;
      _polygons = polygons;
    });
  }

  void _toggleDangerMenu() {
    setState(() {
      _isMenuOpen = true;
    });
    showModalBottomSheet(
        context: context,
        builder: (ctx) => DangerMenuContainer(onMenuSet: _onMenuSet));
  }

  void _onMenuSet() {
    Navigator.pop(context);
    setState(() {
      _isMenuOpen = false;
      _enableLatLngCapture = true;
    });
  }

  void _onMapTap(LatLng latLng) {
    if (_enableLatLngCapture) {
      if (_addedMarkers.length >= 4) {
        return;
      }
      final Marker newMarker = Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        infoWindow: InfoWindow(
            title: 'Captured Point',
            snippet: '${latLng.latitude}, ${latLng.longitude}'),
      );
      _capturedCoordinates.add(latLng);
      setState(() {
        _markers.add(newMarker);
        _addedMarkers.add(newMarker);
      });

      //   ScaffoldMessenger.of(context).showSnackBar(
      // SnackBar(
      //       content: Text('LatLng: ${latLng.latitude}, ${latLng.longitude}')),
      //);
    }
  }

  void _clearAddedMarkers() {
    setState(() {
      _markers.removeAll(_addedMarkers);
      _addedMarkers.clear();
    });
  }

  void _onSave() {
    setState(() {
      _enableLatLngCapture = false;
      _isMenuOpen = false;
      showDialog(
          context: context,
          builder: (ctx) => DangerInfoForm(
                type: 'Italian city',
                coordinates: _capturedCoordinates,
              ));
      _clearAddedMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      SafeArea(
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: defaultLocation,
            zoom: 13,
          ),
          zoomControlsEnabled: false,
          markers: _markers,
          polygons: _polygons,
          onMapCreated: (controller) {
            _mapController = controller;
          },
          onTap: _onMapTap,
        ),
      ),
      Positioned(
        bottom: 20.0,
        right: 20.0,
        child: FloatingActionButton(
          heroTag: 'btn1',
          onPressed: () {
            stopTimer = true;
            _capturedCoordinates = [];
            _toggleDangerMenu();
          },
          child: const Icon(Icons.add),
        ),
      ),
      const Positioned(
        bottom: 20.0,
        left: 20.0,
        child: FloatingActionButton(
          heroTag: 'btn3',
          // onPressed: () async {
          //   //var device = bleController.connectedDevice;
          //   //bleController.sendData(device, "DangerZone");
          //   sendNotification();
          // },
          onPressed: sendNotification,
          child: Text('test notif'),
        ),
      ),
      Positioned(
        top: 60.0,
        left: 20.0,
        child: FloatingActionButton(
          heroTag: 'btn7',
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
          child: const Icon(Icons.menu),
        ),
      ),
      if (_enableLatLngCapture) ...[
        //buttons will show
        //save button
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: FloatingActionButton(
            heroTag: 'btn4',
            onPressed: () {
              setState(() {
                _onSave();
              });
            },
            child: const Text('Save'),
          ),
        ),
        // Clear Button
        Positioned(
          bottom: 20.0,
          left: 20.0,
          child: FloatingActionButton(
            heroTag: 'btn5',
            onPressed: () {
              _clearAddedMarkers();
              _capturedCoordinates = [];
            },
            child: const Text('Clear'),
          ),
        ),
        Positioned(
          bottom: 20.0,
          left: 80.0,
          child: FloatingActionButton(
            heroTag: 'btn6',
            onPressed: () {
              setState(() {
                _enableLatLngCapture = false;
                _clearAddedMarkers();
                _capturedCoordinates = [];
              });
            },
            child: const Text('Exit'),
          ),
        ),
        const Positioned(
            top: 100.0,
            left: 80.0,
            child: Text(
              'Mark th bad zone',
              style: TextStyle(fontSize: 18),
            )),
      ]
    ]);
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AccountPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset(0.0, 0.0);
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
