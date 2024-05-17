import 'package:chating_app/helper/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/authController.dart';
import '../controller/homepageController.dart';
import '../utils/colors.dart';
import '../utils/photoUrl.dart';
import '../widgets/user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageController homePageController = Get.put(HomePageController());
  var list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Get.offNamed('/login');
                Get.snackbar('Logout', 'Logout Success fully');
              });
            },
            icon: Icon(Icons.login_outlined),
          ),
          IconButton(
            onPressed: () {
              // Get.to(
              //   ProfilePage(
              //     user: list[0],
              //   ),
              // );
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
        title: const Text('Chat 💬'),
      ),
      body: Container(
        decoration: BoxDecoration(
        ),
        alignment: Alignment.center,
        child: GetBuilder<HomePageController>(builder: (controller) {
          return CustomScrollView(
            slivers: [
              // SliverAppBar(
              //   backgroundColor: Colors.transparent,
              //   title: Row(
              //     children: [
              //       CircleAvatar(
              //         radius: 25,
              //         backgroundImage: NetworkImage(
              //             (AuthController.currentUser!.photoURL == null)
              //                 ? photoURL
              //                 : AuthController.currentUser!.photoURL!),
              //       ),
              //       const SizedBox(width: 30),
              //       Text(
              //           "${AuthController.currentUser!.email!.split("@")[0].capitalizeFirst}"),
              //     ],
              //   ),
              // ),
              SliverList(
                delegate: SliverChildListDelegate(
                  homePageController.fetchedAllUserData
                      .map((e) => Card(
                    color: Colors.black.withOpacity(0.5),
                    child: ListTile(
                      onTap: () async {
                        await FireStoreHelper.fireStoreHelper
                            .createChatRoomId(
                          AuthController.currentUser!.email!,
                          e.email,
                        );
                        Get.toNamed('/chat', arguments: e);
                      },
                      leading: const FlutterLogo(size: 45),
                      title: Text(e.name),
                      subtitle: Text(e.email),
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
// StreamBuilder(
// stream: APIs.apis.firestore.collection('user').snapshots(),
// builder: (context, snapshot) {
// switch (snapshot.connectionState) {
// case ConnectionState.none:
// case ConnectionState.waiting:
// return Center(
// child: CircularProgressIndicator(),
// );
// case ConnectionState.active:
// case ConnectionState.done:
// final data = snapshot.data?.docs;
// list =
// data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
// if (list.isNotEmpty) {
// return ListView.builder(
// itemCount: list.length,
// itemBuilder: (context, index) {
// return UserCard(
// user: list[index],
// );
// },
// );
// } else {
// return Center(
// child: Text('No Connection Found',
// style: TextStyle(fontSize: 20)),
// );
// }
// }
// },
// )