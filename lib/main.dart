import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/controller/auth_controller.dart';
import 'package:firebase_flutter/pages/Auth/signIn_page.dart';
import 'package:firebase_flutter/qury_data/queryData_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAZAC8RZzT016hFEhAeNme8MCUbboFU07w",
      appId: "1:457926547095:android:47c5b6d6fc798ca377bbd2",
      messagingSenderId: "457926547095",
      projectId: "maul-lagi-belajar",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authC = Get.put(AuthController());
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authC.authStateChanges,
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.active) {
            return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                home: snapshot.data != null &&
                        snapshot.data!.emailVerified == true
                    ? QueryDataPages()
                    : const SignInPage());
          }
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }
}