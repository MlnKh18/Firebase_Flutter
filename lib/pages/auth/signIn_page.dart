import 'package:firebase_flutter/controller/auth_controller.dart';
import 'package:firebase_flutter/pages/auth/forget_password.dart';
import 'package:firebase_flutter/pages/auth/signUp_page.dart';
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
              decoration: const InputDecoration(hintText: 'email'),
            ),
            TextFormField(
              controller: authC.passwordC,
              decoration: const InputDecoration(hintText: 'password'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () => authC.signIn(
                    email: authC.emailC.text, password: authC.passwordC.text),
                child: const Text("Submit"),
              ),
            ),
            ElevatedButton(
                onPressed: () => Get.to(() => const SignUpPage()),
                child: const Text("Daftar")),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                child: const Text('Reset Password'),
                onPressed: () => Get.to(() => const ResetPassword()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
