//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:safetybuddy/pages/home.dart';
import 'package:safetybuddy/pages/landing_page.dart';
import 'package:safetybuddy/pages/login.dart';
import 'package:safetybuddy/pages/register.dart';

void main() => runApp(MaterialApp(initialRoute: '/', routes: {
      //'landing_page': (context) => const LandingPage(),
      '/': (context) => const LandingPage(),
      '/register': (context) => Register(),
      '/login': (context) => const Login(),
      '/home': (context) => const Home(),
    }));
