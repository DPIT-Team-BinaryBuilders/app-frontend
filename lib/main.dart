import 'package:flutter/material.dart';
import 'package:safetybuddy/pages/home.dart';

void main() => runApp(MaterialApp(initialRoute: '/home', routes: {
      //'/': (context) => Loading(),
      '/home': (context) => const Home(),
    }));
