//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safetybuddy/pages/home.dart';
import 'package:safetybuddy/pages/landing_page.dart';
import 'package:safetybuddy/pages/login.dart';
import 'package:safetybuddy/pages/register.dart';
import 'package:safetybuddy/service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AuthService authService = Get.put(AuthService());

  bool isLoggedIn = await authService.isLoggedIn(); // --- de remember me

  runApp(GetMaterialApp(initialRoute: isLoggedIn ? '/home' : '/', getPages: [
    //'landing_page': (context) => const LandingPage(),
    GetPage(name: '/', page: () => const LandingPage()),
    GetPage(name: '/register', page: () => Register()),
    GetPage(name: '/login', page: () => const Login()),
    GetPage(
        name: '/home',
        page: () => const Home(
              stopTimer: false,
            )),
  ]));
}
