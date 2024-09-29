import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safetybuddy/controller/registerController.dart';

class Register extends StatelessWidget {
  Register({super.key});

  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ClipPath(
              clipper: CustomImageClipper(),
              child: Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/vector.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 300),
                    CustomPaint(painter: Line()),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 35,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Username',
                      style: TextStyle(fontSize: 14),
                    ),
                    TextFormField(
                      controller: registerController.username,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        hintText: 'Username',
                        filled: false,
                        prefixIcon: Icon(
                          Icons.mail,
                          size: 24,
                        ),
                      ),
                    ),
                    const Text(
                      'Phone number',
                      style: TextStyle(fontSize: 14),
                    ),
                    TextFormField(
                      controller: registerController.phone_number,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        hintText: '+40** *** ***',
                        filled: false,
                        prefixIcon: Icon(
                          Icons.phone,
                          size: 24,
                        ),
                      ),
                    ),
                    const Text(
                      'Password',
                      style: TextStyle(fontSize: 14),
                    ),
                    TextFormField(
                      controller: registerController.password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        hintText: '********',
                        filled: false,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 24,
                        ),
                      ),
                    ),
                    const Text(
                      'Confirm password',
                      style: TextStyle(fontSize: 14),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: registerController.confirmPassword,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        hintText: '********',
                        filled: false,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 137, 137),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                        ),
                        child: const Text(
                          'Create account',
                          style: TextStyle(fontSize: 19),
                        ),
                        onPressed: () async {
                          await registerController.submit();
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor:
                                const Color.fromARGB(255, 255, 137, 137),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                          ),
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class Line extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint salmonPaint = Paint()
      ..color = const Color.fromARGB(255, 255, 137, 137)
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;

    // p1 stays at 20 pixels from the left
    Offset p1 = Offset(0, size.height * 0.6);

    Offset p2 = Offset(size.width + 70, size.height * 0.6);

    canvas.drawLine(p1, p2, salmonPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
