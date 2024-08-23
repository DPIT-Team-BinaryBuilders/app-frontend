import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: 400,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/vector.png'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomPaint(painter: Line()),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Register',
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 35,
                            )),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Username',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 0),
                      TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: 'Username',
                            filled: false,
                            prefixIcon: const Icon(
                              Icons.mail,
                              size: 24,
                            ),
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.abc), onPressed: () {})),
                      ),
                      const Text(
                        'Numar de telefon',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _phone,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: '+40** *** ***',
                            filled: false,
                            prefixIcon: const Icon(
                              Icons.phone,
                              size: 24,
                            ),
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.abc), onPressed: () {})),
                      ),
                      const Text(
                        'Parolă',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _password,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: '********',
                            filled: false,
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 24,
                            ),
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.abc), onPressed: () {})),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Confirmă parola',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _password,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: '********',
                            filled: false,
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 24,
                            ),
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.abc), onPressed: () {})),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 137, 137),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17)),
                              padding: const EdgeInsets.only(
                                  left: 100, right: 100, top: 15, bottom: 15)),
                          child: const Text(
                            'Creeate an account',
                            style: TextStyle(
                              fontFamily: '',
                              fontSize: 19,
                            ),
                          ),
                          onPressed: () {},
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
                                    vertical: 10, horizontal: 20)),
                            child: const Text('Login'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Line extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint salmonPaint = Paint()
      ..color = const Color.fromARGB(255, 255, 137, 137)
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;

    Offset p1 = Offset(20, size.height * 0.6);
    Offset p2 = Offset(size.width * 0.24, size.height * 0.6);

    canvas.drawLine(p1, p2, salmonPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
