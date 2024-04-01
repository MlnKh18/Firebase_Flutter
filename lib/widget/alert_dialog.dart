import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AlertDialog{
  void alertdialog({required String titletxt, required String midtxt, VoidCallback? onpressed, String? confirmtxt}){
    Get.defaultDialog(
      title: titletxt,
      middleText: midtxt,
      onConfirm: onpressed,
      textConfirm: confirmtxt
    );
  }
}