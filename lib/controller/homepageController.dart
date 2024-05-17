
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../helper/firestore.dart';
import '../models/emailUserModel.dart';

class HomePageController extends GetxController {
  List<UserData> fetchedAllUserData = [];

  @override
  void onInit() async {
    super.onInit();

    List<QueryDocumentSnapshot> data =
    await FireStoreHelper.fireStoreHelper.fetchAllUserData();

    for (var element in data) {
      fetchedAllUserData.add(
        UserData(
            id: element['id'],
            name: element['name'],
            email: element['email'],
            password: element['password']),
      );
    }
    update();
  }
}
