import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DangerInfoForm extends StatefulWidget {
  final String type;

  DangerInfoForm({required this.type, super.key});

  @override
  State<DangerInfoForm> createState() => _DangerInfoFormState();
}

class _DangerInfoFormState extends State<DangerInfoForm> {
  final TextEditingController _description = TextEditingController();
  int _selectedValue = 0;
  late String dangerType;
  late DateTime _createdTime;
  double? _latitude;
  double? _longitude;
  String _locationMessage = '';

  void _getDangerInfo() async {
    // Access the selected radio button value and the description text here
    int selectedDangerLevel = _selectedValue;
    String description = _description.text;
    String type = widget.type;
    _createdTime = DateTime.now();

    // Format the created time
    String formattedTime = "${_createdTime.hour}:${_createdTime.minute}";

    // Fetch current location
    Position position = await _determinePosition();
    _latitude = position.latitude;
    _longitude = position.longitude;

    //setState(() {
    //_locationMessage = 'Latitude: $_latitude, Longitude: $_longitude';
    //});

    // Print values to console for demonstration
    print('Danger Type: $type');
    print('Description: $description');
    print('Selected Danger Level: $selectedDangerLevel');
    print('Time Created: $formattedTime');
    print('Location: Latitude: $_latitude, Longitude: $_longitude');
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, do not continue
      // accessing the position and request users of the
      // App to enable the location services.
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value ?? 0;
    });
  }

  Widget _buildRadioButton(int value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Radio<int>(
          value: value,
          groupValue: _selectedValue,
          onChanged: _handleRadioValueChange,
        ),
        Text('${value}'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Danger info'),
      actions: <Widget>[
        TextButton(
          child: const Text('Submit'),
          onPressed: () {
            _getDangerInfo();
            Navigator.of(context).pop();
          },
        ),
      ],
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                child: Text('Level of danger'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildRadioButton(1),
                  _buildRadioButton(2),
                  _buildRadioButton(3),
                  _buildRadioButton(4),
                  _buildRadioButton(5),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
