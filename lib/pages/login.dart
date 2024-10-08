import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safetybuddy/controller/loginController.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 430,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/vector.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 2,
                      width: 60,
                      color: const Color(0xFFFF6F61),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Username'),
                      controller: loginController.username,
                    ),
                    TextFormField(
                      controller: loginController.password,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () async {
                              //await loginController.submit();
                              Get.toNamed("/home");
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Color.fromARGB(255, 255, 137, 137),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 30.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an acocount?"),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(
                        '/register',
                      );
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20)),
                    ),
                    child: const Text('Create account'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
