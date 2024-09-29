import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safetybuddy/service/danger_service.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomPaint(
            painter: WavyBackgroundPainter(),
            child: Container(
              height: 400,
            ),
          ),
          Positioned(
            left: 5,
            top: 20,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/profile_male.png'),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'btn5',
            onPressed: () {
              authService.logout();
            },
            label: const Text('Logout'),
            icon: const Icon(Icons.logout),
            backgroundColor: Colors.red,
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            heroTag: 'btn2',
            onPressed: () {
              Get.toNamed('/ble');
            },
            label: const Text("Connect"),
            icon: const Icon(Icons.bluetooth),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class WavyBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..color = const Color.fromARGB(255, 255, 137, 137)
      ..style = PaintingStyle.fill;

    Path path = Path();

    path.lineTo(0, size.height * 0.55);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.45,
        size.width * 0.5, size.height * 0.55);

    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.65, size.width, size.height * 0.55);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint1);
    path.close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
