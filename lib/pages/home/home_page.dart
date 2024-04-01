import 'package:firebase_flutter/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authC = Get.find();
    return Scaffold(
      appBar: AppBar(
        title:const Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () => authC.logout(),
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
    );
  }
}
