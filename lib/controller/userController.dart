import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to save user details to Firestore
  Future<void> saveUserDetails(ChatUser user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toJson());
      Get.snackbar('Success', 'User details saved successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Function to get user details from Firestore
  Future<ChatUser?> getUserDetails(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        return ChatUser.fromJson(data);
      } else {
        Get.snackbar('Error', 'User not found');
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }
}
