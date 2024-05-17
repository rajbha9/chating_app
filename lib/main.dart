import 'package:chating_app/firebase_options.dart';
import 'package:chating_app/views/chatpage.dart';
import 'package:chating_app/views/homepage.dart';
import 'package:chating_app/views/login.dart';
import 'package:chating_app/views/profile_page.dart';
import 'package:chating_app/views/singup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute:
          (FirebaseAuth.instance.currentUser != null) ? '/' : '/login',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignUpPage(),
        ),
        GetPage(
          name: '/chat',
          page: () => ChatScreen(),
        ),

        // GetPage(
        //   name: '/profile',
        //   page: () => ProfilePage(user: null,),
        // ),
      ],
    );
  }
}
