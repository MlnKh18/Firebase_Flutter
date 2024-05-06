import 'package:firebase_flutter/controller/add_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertForm extends StatelessWidget {
  const AlertForm({super.key,});

  @override
  Widget build(BuildContext context) {
    final addUserC = Get.put(AddUserController());
    return AlertDialog(
      title: const Text('Input Form'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: addUserC.nameC,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: addUserC.ageC,
            decoration: const InputDecoration(labelText: 'Age'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Tambahkan logika untuk menutup dialog
            addUserC.updateUser(
                name: addUserC.nameC.text, age: int.parse(addUserC.ageC.text));
            Get.back();
          },
          child: const Text('Update'),
        ),
        ElevatedButton(
          onPressed: () {
            // Tambahkan logika untuk mengirim data form
            // Anda dapat mengakses data dari TextField menggunakan TextEditingController
            // atau menyimpan data di dalam state jika menggunakan Stateful widget
            addUserC.addUser(
                name: addUserC.nameC.text, age: int.parse(addUserC.ageC.text));
            Get.back();
          },
          child: const Text('add'),
        ),
      ],
    );
  }
}
