import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DangerService {
  Future<http.Response> saveDanger(
      String type,
      String description,
      String dangerLevel,
      String timeCreated,
      double latitude,
      double longitude) async {
    var uri = Uri.parse("DATABASE RERVER"); // to replace with server link

    Map<String, String> headers = {"Content-Type": "application/json"};

    Map<String, dynamic> data = {
      'type': type,
      'description': description,
      'dangerLevel': dangerLevel,
      'timeCreated': timeCreated,
      'latitude': latitude,
      'longitude': longitude,
    };

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
    var uri = Uri.parse("DATABASE LINK");

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
