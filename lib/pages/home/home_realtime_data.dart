import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/controller/home_controller.dart';
import 'package:firebase_flutter/widget/alert_dialog_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RealTimeDataPage extends StatelessWidget {
  final HomeController homeC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real Time Data'),
      ),
      body: StreamBuilder(
        stream: homeC.getDataRealTime(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
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
            builder: (_) => AlertForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
