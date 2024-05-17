import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helper/firestore.dart';

class SignupController extends GetxController {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController loginemailcontroller = TextEditingController();
  TextEditingController loginpasswordcontroller = TextEditingController();
  TextEditingController cpasswordcontroller = TextEditingController();

  creatAccount() async {
    String email = emailcontroller.text.trim();
    String pass = passwordcontroller.text.trim();
    String cpass = cpasswordcontroller.text.trim();
    if (email == '' || pass == '' || cpass == '') {
      print('please fill detail...');
      Get.snackbar('Alert', 'Please fill details...');
    } else if (pass != cpass) {
      print('password do not mache');
      Get.snackbar('Alert', 'Password does not mache...');
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass);
        if (userCredential.user != null) {
          // APIs.apis.createUser();
          Get.back();
          emailcontroller.clear();
          cpasswordcontroller.clear();
          passwordcontroller.clear();
        }
        print('new user added');
        Get.snackbar('Success', 'Account has been created success fully...');
      } on FirebaseException catch (exception) {
        print(exception.code.toString());
      }
    }
  }

  loginAccount() async {
    String email = loginemailcontroller.text.trim();
    String password = loginpasswordcontroller.text.trim();
    if (email == '' || password == '') {
      Get.snackbar('Alert', 'Please fill detail');
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential != null) {
          // APIs.apis.userExists();
          Get.snackbar('success', 'Login success');
          Get.offNamed('/')!.then((value) {
            loginpasswordcontroller.clear();
            loginemailcontroller.clear();
          });
        }
      } on FirebaseException catch (exception) {
        Get.snackbar('error', '${exception.code.toString()}');
      }
    }
  }
}
