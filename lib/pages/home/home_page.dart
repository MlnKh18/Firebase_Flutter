import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/controller/auth_controller.dart';
import 'package:firebase_flutter/controller/home_controller.dart';
import 'package:firebase_flutter/pages/home/home_realtime_data.dart';
import 'package:firebase_flutter/widget/alert_dialog_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomeController homeC = Get.put(HomeController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authC = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () => authC.logout(),
            icon: const Icon(Icons.logout_outlined),
          ),
          IconButton(
            onPressed: () => Get.to(() =>  RealTimeDataPage()),
            icon: const Icon(Icons.data_array),
          ),
        ],
      ),
      body: FutureBuilder(
        future: homeC.getDataUser(),
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
            /// Baris `final data = snapshot.data!.docs;` sedang mengekstraksi dokumen dari
            /// Objek `QuerySnapshot` yang diperoleh dari operasi pengambilan data asinkron
            /// dari Firestore.
            final data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final document = data[index];
                final name =
                    document['name']; // Ganti 'name' dengan field yang sesuai
                final age =
                    document['age']; // Ganti 'age' dengan field yang sesuai

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
