import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safetybuddy/models/user_model.dart';

class RegisterController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phone_number = TextEditingController();

  late String _message;

  Future<void> submit() async {
    print("Entered submit method");
    User user = User(
        username: username.text.trim(),
        password: password.text.trim(),
        phone_number: phone_number.text.trim());

    try {
      print("Validating user data");
      bool validateUserData = ValidateUserData(user);
      if (validateUserData) {
        //user data ok
        bool serverResponse = await registerUser(user);
        if (serverResponse) {
          print("User registration successful");

          await showMessage(
              context: Get.context!,
              title: 'Succes!',
              message: 'User register Succesful');
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
    if (user.password.toString().isEmpty) {
      _message = "Password required";
      return false;
    }
    if (confirmPassword.toString().isEmpty) {
      _message = "Confirm password required";
      return false;
    }
    if (user.password != confirmPassword.text.trim()) {
      _message = "Passwords do not match";
      return false;
    }

    if (user.phone_number.toString().isEmpty) {
      _message = "Phone nuber required";
      return false;
    }
    print("User data ok avans");
    return true;
  }

  Future<bool> registerUser(User user) async {
    Dio dio = Dio();
    String _apiUrl = "http://192.168.1.180:8081/auth/register";

    try {
      Map<String, dynamic> requestData = {
        'username': user.username,
        'password': user.password,
        'email': user.email,
        'phone_number': user.phone_number,
      };
      final response = await dio.post(_apiUrl, data: requestData);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
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
