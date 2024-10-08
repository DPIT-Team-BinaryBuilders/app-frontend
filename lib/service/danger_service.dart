import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:safetybuddy/service/auth_service.dart';

final AuthService authService = Get.put(AuthService());

class DangerService {
  Future<http.Response> saveDanger(
      String type,
      String description,
      String dangerLevel,
      String timeCreated,
      double latitude,
      double longitude,
      List<LatLng> rectanglePoints) async {
    var uri = Uri.parse(
        "http://192.168.1.180:8083/danger/create"); // to replace with server link

    Map<String, String> headers = {"Content-Type": "application/json"};
    Map<String, dynamic> data;
    if (rectanglePoints.isNotEmpty) {
      data = {
        'name': "dfdfd",
        'additionalInformation': "test",
        "accuracy": 6.9,
        'type': type,
        'description': description,
        'dangerLevel': dangerLevel,
        'timeCreated': timeCreated,
        "duration": "2012-04-23T18:25:43.511Z",
        "dangerLocation": {'lat': latitude, 'lng': longitude},
        'jwtToken': await authService.getToken(),
        "rectanglePoints": [
          {
            'lat': rectanglePoints[0].latitude,
            'lng': rectanglePoints[0].longitude
          },
          {
            'lat': rectanglePoints[1].latitude,
            'lng': rectanglePoints[1].longitude
          },
          {
            'lat': rectanglePoints[2].latitude,
            'lng': rectanglePoints[2].longitude
          },
          {
            'lat': rectanglePoints[3].latitude,
            'lng': rectanglePoints[3].longitude
          }
        ],
      };
    } else {
      data = {
        'name': "dfdfd",
        'additionalInformation': "test",
        "accuracy": 6.9,
        'type': type,
        'description': description,
        'dangerLevel': dangerLevel,
        'timeCreated': timeCreated,
        "duration": "2012-04-23T18:25:43.511Z",
        "dangerLocation": {'lat': latitude, 'lng': longitude},
        'jwtToken': await authService.getToken(),
        "rectanglePoints": []
      };
    }
    print(data);

    var body = json.encode(data);
    var response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Data saved successfully: ${response.body}");
    } else {
      print("Failed to save data: ${response.statusCode} ${response.body}");
    }

    return response;
  }

  Future<List<dynamic>> fetchDangers() async {
    var uri = Uri.parse("http://192.168.1.180:8083/danger/all");

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      print("Failed to fetch data: ${response.statusCode} ${response.body}");
      return [];
    }
  }
}
