import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/controller/home_controller.dart';
import 'package:firebase_flutter/widget/alert_dialog_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RealTimeDataPage extends StatelessWidget {
  final HomeController homeC = Get.find();

  RealTimeDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        title: const Text('Real Time Data'),
      ),
      body:

          /// Widget `StreamBuilder` di Flutter digunakan untuk mendengarkan aliran data dan membangun kembali
          /// dirinya sendiri setiap kali data baru tersedia di aliran. Dalam cuplikan kode yang disediakan, file
          /// `StreamBuilder` mendengarkan aliran yang dikembalikan oleh metode `homeC.getDataRealTime()`,
          /// yang kemungkinan merupakan aliran data dari database real-time seperti Firestore.
          StreamBuilder(
        stream: homeC.getDataRealTime(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final document = data[index];
                final name = document['name'];
                final age = document['age'];

                return ListTile(
                  title: Text("Name: $name"),
                  subtitle: Text("Age: $age"),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AlertForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
