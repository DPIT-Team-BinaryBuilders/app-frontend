import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safetybuddy/pages/account_page.dart';
import 'package:safetybuddy/pages/bluetooth_scanner.dart';
import 'package:safetybuddy/pages/home.dart';
import 'package:safetybuddy/pages/landing_page.dart';
import 'package:safetybuddy/pages/login.dart';
import 'package:safetybuddy/pages/register.dart';
import 'package:safetybuddy/service/auth_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    'resource_key',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50b8),
        ledColor: Colors.white,
      )
    ],
  );

  final AuthService authService = Get.put(AuthService());

  bool isLoggedIn = false; //await authService.isLoggedIn();

  MaterialApp(debugShowCheckedModeBanner: false);
  CupertinoApp(debugShowCheckedModeBanner: false);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner globally
      initialRoute: isLoggedIn ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LandingPage()),
        GetPage(name: '/register', page: () => Register()),
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/ble', page: () => const BleScanner()),
        GetPage(name: '/account', page: () => AccountPage()),
        GetPage(name: '/home', page: () => const Home(stopTimer: false)),
      ],
    ),
  );
}
