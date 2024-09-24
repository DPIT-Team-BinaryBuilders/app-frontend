import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:safetybuddy/controller/bluetoothController.dart';
import 'package:safetybuddy/pages/bluetooth_scanner.dart';

getUserLocation() async {
  String userLocation;
  Position position = await Geolocator.getCurrentPosition();
  userLocation = "${position.latitude},${position.longitude}";
  return userLocation;
}

checkLocationStatus(userLocation) async {
  Dio dio = Dio();
  String _apiUrl = "de completat";
  final BleController bleController = Get.put(BleController());

  Map<String, dynamic> data = {userLocation: getUserLocation()};
  final response = await dio.post(_apiUrl, data: data);

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = response.data;
    var distance = responseData['distance'];
    if (1 == 1) {
      //notif send condittion
      if (BluetoothConnectionState.connected == true) {
        // Sends DangerZone to watch
        print("trimit activare ceas");
        var device = bleController.connectedDevice;
        bleController.sendData(device!, "DangerZone");
      }
    }
  }
}
