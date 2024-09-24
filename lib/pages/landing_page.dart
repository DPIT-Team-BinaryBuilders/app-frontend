import 'package:flutter/material.dart';
import 'package:safetybuddy/pages/register.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/vector.png'),
            fit: BoxFit.fill,
          )),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Welcome!',
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 35,
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: const Text(
                          'Your safe travel app',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: '',
                            fontSize: 18,
                            color: Color.fromARGB(255, 137, 137, 137),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          alignment: Alignment.bottomRight,
                          backgroundColor: Colors.white,
                          foregroundColor:
                              const Color.fromARGB(255, 255, 137, 137),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 255, 137, 137)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        icon: const Text(
                          'Next',
                          style: TextStyle(fontSize: 18, fontFamily: ''),
                        ),
                        label: Image.asset(
                          'assets/arrow-right.png',
                          width: 24,
                          height: 24,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
