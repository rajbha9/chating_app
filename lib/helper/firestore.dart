import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/authController.dart';
import '../models/emailUserModel.dart';
import '../models/fetchusers.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  File? imageFile;
  String? imageUrl;

  Future<void> addUserInFireStoreDatabase(UserData userData) async {
    await firebaseFirestore.collection('users').doc().set({
      'id': userData.id,
      'name': userData.name,
      'email': userData.email,
      'password': userData.password,
    });
  }

  Future<List<QueryDocumentSnapshot>> fetchAllUserData() async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection('users')
        .where("email", isNotEqualTo: AuthController.currentUser!.email)
        .get();

    List<QueryDocumentSnapshot> data = querySnapshot.docs;

    return data;
  }

  bool alreadyIdExists(String u1, String u2, FetchChatUserId element) {
    if ((u1 == element.user1 || u1 == element.user2) &&
        (u2 == element.user1 || u2 == element.user2)) {
      if (u1 == element.user1 && u2 == element.user2) {
        AuthController.currentChatRoomId = "${u1}_$u2";
        print(AuthController.currentChatRoomId);
        print("++++++++++++++++++++++++");
      } else {
        AuthController.currentChatRoomId = "${u2}_$u1";
        print(AuthController.currentChatRoomId);
        print("-------------////////////");
      }
      return true;
    }
    return false;
  }

  Future<void> createChatRoomId(String u1, String u2) async {
    List<FetchChatUserId> fetchedChatsId = [];
    QuerySnapshot querySnapshot =
    await firebaseFirestore.collection('chats').get();

    List<QueryDocumentSnapshot> data = querySnapshot.docs;

    if (data.isEmpty) {
      AuthController.currentChatRoomId = "${u1}_$u2";
      await firebaseFirestore
          .collection('chats')
          .doc(AuthController.currentChatRoomId)
          .set({
        'chat_id': AuthController.currentChatRoomId,
      });
      print(AuthController.currentChatRoomId);
      print("====================");
    } else {
      fetchedChatsId = data.map((e) {
        String fetchUser1 = e['chat_id'].toString().split("_")[0];
        String fetchUser2 = e['chat_id'].toString().split("_")[1];
        return FetchChatUserId(user1: fetchUser1, user2: fetchUser2);
      }).toList();

      for (var e in fetchedChatsId) {
        print("u1 = ${e.user1}");
        print("u2 = ${e.user2}");
      }
      bool? alreadyId = false;
      for (var element in fetchedChatsId) {
        alreadyId = alreadyIdExists(u1, u2, element);
        if (alreadyId) {
          break;
        }
      }
      if (alreadyId == false) {
        AuthController.currentChatRoomId = "${u1}_$u2";
        await firebaseFirestore
            .collection('chats')
            .doc(AuthController.currentChatRoomId)
            .set({
          'chat_id': AuthController.currentChatRoomId,
        });
        print(AuthController.currentChatRoomId);
        print("----------_____________");
      }
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages() {
    return firebaseFirestore
        .collection('chats')
        .doc(AuthController.currentChatRoomId)
        .collection('messages')
        .orderBy('time', descending: false)
        .snapshots();
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();

    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (xFile != null) {
      imageFile = File(xFile.path);
      uploadImage();
    }
  }

  Future uploadImage() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    String path = DateTime.now().microsecond.toString();

    Reference ref = firebaseStorage.ref().child("images").child('$path.jpg');

    TaskSnapshot uploadTask = await ref.putFile(imageFile!);

    imageUrl = await uploadTask.ref.getDownloadURL();

    print(imageUrl);
  }

  Future<void> sendMessage(
      String sender, String receiver, String message) async {
    firebaseFirestore
        .collection('chats')
        .doc(AuthController.currentChatRoomId)
        .collection('messages')
        .doc()
        .set({
      'sender': sender,
      'receiver': receiver,
      'type': (imageUrl != null) ? 'img' : 'text',
      'message': message,
      'time': DateTime.now(),
    });
  }
}
