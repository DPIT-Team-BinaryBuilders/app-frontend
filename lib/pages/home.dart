import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';
import 'danger_menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const LatLng _pGooglePlex = LatLng(46.163765, 24.351249);
  bool _isDangerMenuVisible = false;

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
        child: const GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _pGooglePlex,
            zoom: 13,
          ),
          zoomControlsEnabled: false,
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
