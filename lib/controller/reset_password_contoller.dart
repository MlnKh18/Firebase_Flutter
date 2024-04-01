import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetController extends GetxController {
  late TextEditingController emailC, passwordC;
  @override
  void onInit() {
    super.onInit();
    emailC = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    emailC.dispose();
  }

  void resetPassword() {}
}
