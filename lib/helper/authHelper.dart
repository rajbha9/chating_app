import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../controller/authController.dart';
import '../models/emailUserModel.dart';
import 'firestore.dart';

class AuthHelper {
  AuthHelper._();

  static final AuthHelper authHelper = AuthHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> signUpUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserData userData = UserData(
          id: userCredential.user!.uid,
          name: "${email.split("@")[0].capitalizeFirst}",
          email: email,
          password: password);

      await FireStoreHelper.fireStoreHelper
          .addUserInFireStoreDatabase(userData);
      if (userCredential.user != null) {
        Get.back();
      }
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
    }
    return null;
  }

  Future<String?> loginUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      AuthController.currentUser = userCredential.user;
      Get.snackbar('success', 'Login success');
      Get.offNamed('/');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return 'Invalid Credential';
      }
    }

    // ZegoUIKitPrebuiltCallInvitationService().init(
    //   appID: 1182374150 /*input your AppID*/,
    //   appSign:
    //   "29ca099d06f61e312d8feb34e335f1bb539e0ea4f800e291a0b45fdfdcdbc743" /*input your AppSign*/,
    //   userID: AuthController.currentUser!.email!,
    //   userName: AuthController.currentUser!.email!,
    //   plugins: [ZegoUIKitSignalingPlugin()],
    // );
    // return null;
  }

  Future<User?> loginUserWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    AuthController.currentUser = userCredential.user;

    return userCredential.user;
  }
}
