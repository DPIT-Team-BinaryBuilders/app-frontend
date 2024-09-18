import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

getUserLocation() async {
  String userLocation;
  Position position = await Geolocator.getCurrentPosition();
  userLocation = "${position.latitude},${position.longitude}";
  return userLocation;
}

checkLocationStatus(userLocation) async {
  Dio dio = Dio();
  String _apiUrl = "de completat";

  Map<String, dynamic> data = {userLocation: getUserLocation()};
  final response = await dio.post(_apiUrl, data: data);
  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = response.data;
    var distance = responseData['distance'];
    //if (distance < de ales) {
    //send signal to bluetooth
    //}
  }
}
