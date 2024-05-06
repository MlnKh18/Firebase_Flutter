import 'package:firebase_flutter/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authC = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: authC.emailC,
              decoration: const InputDecoration(hintText: 'email'),
            ),
            TextFormField(
              controller: authC.passwordC,
              decoration: const InputDecoration(hintText: 'password'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                  onPressed: () => authC.signUp(
                      email: authC.emailC.text, password: authC.passwordC.text),
                  child: const Text("Submit")),
            )
          ],
        ),
      ),
    );
  }
}
