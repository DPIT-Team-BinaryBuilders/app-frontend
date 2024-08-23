import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';
import '../service/service.dart';
import 'danger_menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const LatLng defaultLocation = LatLng(46.163765, 24.351249);
  late GoogleMapController _mapController;
  Service service = Service();
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadDangers();
  }

  Future<void> _loadDangers() async {
    List<dynamic> dangers = await service.fetchDangers();

    Set<Marker> markers = {};
    for (var danger in dangers) {
      markers.add(
        Marker(
          markerId: MarkerId(danger['id'].toString()),
          position: LatLng(danger['latitude'], danger['longitude']),
          infoWindow: InfoWindow(
            title: danger['type'],
            snippet: danger['description'],
          ),
        ),
      );
    }

    setState(() {
      _markers = markers;
    });
  }

  void _toggleDangerMenu() {
    setState(() {
      showModalBottomSheet(
          context: context, builder: (ctx) => DangerMenuContainer());
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
          onMapCreated: (controller) {
            _mapController = controller;
          },
        ),
      ),
      Positioned(
        bottom: 20.0,
        right: 20.0,
        child: FloatingActionButton(
          onPressed: _toggleDangerMenu,
          child: const Icon(Icons.add),
        ),
      ),
    ]);
  }
}
