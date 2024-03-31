import 'package:firebase_flutter/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authC = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: authC.emailC,
              decoration: InputDecoration(hintText: 'email'),
            ),
            TextFormField(
              controller: authC.passwordC,
              decoration: InputDecoration(hintText: 'password'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                  onPressed: () => authC.signIn(email: authC.emailC.text, password: authC.passwordC.text),
                  child: Text("Submit")),
            )
          ],
        ),
      ),
    );
  }
}