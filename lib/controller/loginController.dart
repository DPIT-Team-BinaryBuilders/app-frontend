import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safetybuddy/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  late String _message;

  Future<void> submit() async {
    print("Entered submit method");
    User user = User(
      username: username.text.trim(),
      password: password.text.trim(),
    );

    try {
      print("Validating user data");
      bool validateUserData = ValidateUserData(user);
      if (validateUserData) {
        //user data ok
        bool serverResponse = await loginUser(user);
        if (serverResponse) {
          print("User Login Successful");
          await showMessage(
              context: Get.context!,
              title: 'Succes!',
              message: 'User Login Succesful');
          Get.toNamed(
            '/home',
          );
        } else {
          await showMessage(
              context: Get.context!,
              title: 'Error',
              message: 'Incorect Username or Password');
        }
      } else {
        print("User data validation failed");
        await showMessage(
            context: Get.context!, title: 'Error', message: _message);
      }
    } catch (e) {}
  }

  bool ValidateUserData(User user) {
    print("Start to validate");
    if (user.username.toString().isEmpty) {
      _message = "Usename required";
      return false;
    }
    if (user.username.toString().isEmpty && user.password.toString().isEmpty) {
      _message = "Usename required and password required";
      return false;
    }
    if (user.password.toString().isEmpty) {
      _message = "Password required";
      return false;
    }

    print("User data ok avans");
    return true;
  }

  Future<bool> loginUser(User user) async {
    Dio dio = Dio();
    String _apiUrl =
        "http://192.168.1.180:8081/auth/login"; // de pus linkul de la rest postman

    try {
      Map<String, dynamic> requestData = {
        'username': user.username,
        'password': user.password,
      };
      final response = await dio.post(_apiUrl, data: requestData);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        String? token = responseData['jwtToken']; //jwtToken pt test adevarat

        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          print("Token saved successfully");
          print("Token: $token");
          return true;
        } else {
          print("Token not received");
          return false;
        }
      } else {
        print("Login failed with status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error occurred: $e");
      return false;
    }
  }

  showMessage(
      {required BuildContext context,
      required String title,
      required String message}) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('Ok'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
