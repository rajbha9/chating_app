import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/authController.dart';
import '../helper/firestore.dart';
import '../models/emailUserModel.dart';
import '../models/getmessege.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    UserData userData = ModalRoute.of(context)!.settings.arguments as UserData;

    TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(userData.name),
        elevation: 3,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: StreamBuilder(
          stream: FireStoreHelper.fireStoreHelper.getMessages(),
          builder: (context, snapshot) {
            List<GetMessageData> fetchData = [];

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      const Expanded(
                        flex: 12,
                        child: Center(child: Text("Say Hello 🖐")),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: TextField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  hintText: "Enter message",
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: FloatingActionButton(
                                onPressed: () async {
                                  await FireStoreHelper.fireStoreHelper
                                      .sendMessage(
                                          AuthController.currentUser!.email!,
                                          userData.email,
                                          messageController.text)
                                      .then((value) {
                                    messageController.clear();
                                  });
                                },
                                elevation: 0,
                                child: const Icon(Icons.send),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                fetchData = snapshot.data!.docs
                    .map((e) => GetMessageData(
                        message: e['message'],
                        time: e['time'],
                        sender: e['sender'],
                        type: e['type']))
                    .toList();
                return Column(
                  children: [
                    Expanded(
                      flex: 12,
                      child: ListView(
                        controller: scrollController,
                        children: fetchData
                            .map(
                              (e) => Row(
                                mainAxisAlignment: (e.sender ==
                                        AuthController.currentUser!.email)
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: (e.type == "img")
                                        ? Container(
                                            height: 200,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(e.message),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : Chip(
                                            label: Column(
                                              crossAxisAlignment: (e.sender ==
                                                      AuthController
                                                          .currentUser!.email)
                                                  ? CrossAxisAlignment.end
                                                  : CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.message,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  '${e.time.toDate().hour}:${e.time.toDate().minute}',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                hintText: "Enter message",
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: FloatingActionButton(
                              onPressed: () => FireStoreHelper.fireStoreHelper
                                  .getImage()
                                  .then((value) {
                                Get.toNamed('pickedImage',
                                    arguments: userData.email);
                              }),
                              elevation: 0,
                              child: const Icon(Icons.image),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: FloatingActionButton(
                              onPressed: () async {
                                await FireStoreHelper.fireStoreHelper
                                    .sendMessage(
                                        AuthController.currentUser!.email!,
                                        userData.email,
                                        messageController.text)
                                    .then((value) {
                                  messageController.clear();
                                });

                                scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeOut);
                              },
                              elevation: 0,
                              child: const Icon(Icons.send),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}

class PickedImageView extends StatelessWidget {
  const PickedImageView({super.key});

  @override
  Widget build(BuildContext context) {
    String userDataEmail = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: Colors.black12.withOpacity(0.4),
      body: Center(
        child: Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(FireStoreHelper.fireStoreHelper.imageFile!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FireStoreHelper.fireStoreHelper
              .sendMessage(AuthController.currentUser!.email!, userDataEmail,
                  FireStoreHelper.fireStoreHelper.imageUrl!)
              .then((value) {
            Get.back();
          });
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}
