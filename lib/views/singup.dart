import 'package:chating_app/controller/signupcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/authHelper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controller = Get.put(SignupController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: Get.height * 0.03,
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
                        controller: controller.emailcontroller,
                        decoration: InputDecoration(
                          hintText: 'Email..',
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
                        controller: controller.passwordcontroller,
                        decoration: InputDecoration(
                          hintText: 'Password..',
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
                            'Conform Password',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: controller.cpasswordcontroller,
                        decoration: InputDecoration(
                          hintText: 'Conform Password..',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          // controller.creatAccount();
                          // controller.emailcontroller.clear();
                          // controller.cpasswordcontroller.clear();
                          // controller.passwordcontroller.clear();
                          await AuthHelper.authHelper
                              .signUpUserWithEmailAndPassword(
                                  email: controller.emailcontroller.text.trim(),
                                  password: controller.passwordcontroller.text
                                      .trim());
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          alignment: Alignment.center,
                          child: const Text('Login'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
