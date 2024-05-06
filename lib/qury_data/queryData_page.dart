import 'package:firebase_flutter/controller/query_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueryDataPages extends StatelessWidget {
  QueryDataPages({super.key});
  final filterC = Get.put(QueryDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "QueryData CloudFire View ",
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: filterC.limitier(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () => filterC.limitier(),
                    child: Text(
                      "Tap",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              }
              return Text("data");
            }));
  }
}
