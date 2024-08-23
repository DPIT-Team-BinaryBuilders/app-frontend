import '../service/danger_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DangerInfoForm extends StatefulWidget {
  final String type;

  const DangerInfoForm({required this.type, super.key});

  @override
  State<DangerInfoForm> createState() => _DangerInfoFormState();
}

class _DangerInfoFormState extends State<DangerInfoForm> {
  Service service = Service();

  final TextEditingController _description = TextEditingController();
  int _selectedValue = 0;
  late String dangerType;
  late DateTime _createdTime;
  double? _latitude;
  double? _longitude;
  String? _formatedTime;

  Future<void> _getDangerInfo() async {
    int selectedDangerLevel = _selectedValue;
    String description = _description.text;
    String type = widget.type;
    _createdTime = DateTime.now();

    _formatedTime = "${_createdTime.hour}:${_createdTime.minute}";

    Position position = await _determinePosition();
    _latitude = position.latitude;
    _longitude = position.longitude;

    //setState(() {
    //_locationMessage = 'Latitude: $_latitude, Longitude: $_longitude';
    //});

    print('Danger Type: $type');
    print('Description: $description');
    print('Selected Danger Level: $selectedDangerLevel');
    print('Time Created: $_formatedTime');
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
        Text('$value'),
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
          onPressed: () async {
            await _getDangerInfo();
            if (_formatedTime != null &&
                _latitude != null &&
                _longitude != null) {
              service.saveDanger(
                  widget.type,
                  _description.text,
                  _selectedValue.toString(),
                  _formatedTime!,
                  _latitude!,
                  _longitude!);
              Navigator.of(context).pop();
            } else {
              print('Error: Location or time data is not available');
            }
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
