import 'package:firebase_flutter/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends GetView<ResetPassword> {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: authC.emailC,
              decoration: InputDecoration(hintText: 'email'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                  onPressed: () =>
                      authC.resetPassword(email: authC.emailC.text),
                  child: Text("Submit")),
            )
          ],
        ),
      ),
    );
  }
}
