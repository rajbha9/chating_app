import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controller/googlesign.dart';
import '../controller/signupcontroller.dart';
import '../helper/authHelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(SignupController());
  final googlecontroller = Get.put(GoogleSign());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: Get.height * 0.05,
            ),
            Container(
              height: Get.height * 0.15,
              child: Image.asset('asset/img/chating.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, right: 15, left: 15, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Email',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: controller.loginemailcontroller,
                        decoration: InputDecoration(
                          // hintStyle: TextStyle(color: Colors.black,letterSpacing: 1),
                          hintText: 'Enter your email..',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Password',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: controller.loginpasswordcontroller,
                        decoration: InputDecoration(
                          hintText: 'Enter your password..',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              // controller.loginAccount();
                              await AuthHelper.authHelper
                                  .loginUserWithEmailAndPassword(
                                      email: controller
                                          .loginemailcontroller.text
                                          .trim(),
                                      password: controller
                                          .loginpasswordcontroller.text
                                          .trim());
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              alignment: Alignment.center,
                              child: const Text('Login'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/signup');
                            },
                            child: const Text(
                              'Create Account',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      onPressed: () {
                        AuthHelper.authHelper.loginUserWithGoogle().then((value) {
                          Get.offNamed('/');
                        });
                      },
                      icon: Image.asset('asset/img/search.png'),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'asset/img/phone.png',
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset('asset/img/facebook.png'),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'asset/img/apple.png',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
