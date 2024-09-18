import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safetybuddy/pages/danger_info.dart';
import 'package:safetybuddy/service/auth_service.dart';
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

  void _dangerRefresh() {
    _loadDangers();
    if (!stopTimer) {
      _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
        _loadDangers(); //refreshes dangers on map
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
      Positioned(
        top: 50.0,
        right: 20.0,
        child: FloatingActionButton(
          heroTag: 'btn2',
          onPressed: () {
            Get.toNamed(
              '/ble',
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      Positioned(
        bottom: 20.0,
        left: 20.0,
        child: FloatingActionButton(
          heroTag: 'btn3',
          onPressed: _loadDangers,
          child: const Text('logout'),
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
              'Mark the neighbourhood',
              style: TextStyle(fontSize: 18),
            )),
      ]
    ]);
  }
}
