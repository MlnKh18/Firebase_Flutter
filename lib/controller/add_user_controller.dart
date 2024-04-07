import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUserController extends GetxController {
  final db = FirebaseFirestore.instance.collection("user");
  CollectionReference user = FirebaseFirestore.instance.collection('user');
  late TextEditingController nameC, ageC;

  @override
  void onInit() {
    super.onInit();
    nameC = TextEditingController();
    ageC = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    nameC.dispose();
    ageC.dispose();
  }

  Future<void> addUser({required String name, required int age}) {
    // dalam firebase ada dua metode untuk menambahkan data pertama dengan  .add() dan kedua dengan .doc().set()
    // return db
    //     .add({'name': name, 'age': age})
    //     .then((value) => print("User Added"))
    //     .catchError((error) => print("Failed to add user: $error"));

    // didatam .doc().set() ketika menaruh doc maka itu seakan" kita mengupdate value dari IDnya
    return db.doc().set({'name': name, 'age': age});
  }

  Future<void> updateUser({required String name, required int age}) {
    return db.doc("hEDJAIELOiukh4K2PPAu").update({
      "timestamp": FieldValue.serverTimestamp(),
      "name": name,
      "age": age
    }).then((value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));

    // Jika dokumen berisi objek bertingkat, Anda dapat menggunakan "notasi titik" untuk merujuk ke kolom bertingkat dalam dokumen saat memanggil update()
// {
//   name: "Frank",
//   favorites: { food: "Pizza", color: "Blue", subject: "recess" }
//   age: 12
// }
// db
//     .collection("users")
//     .doc("frank")
//     .update({"age": 13, "favorites.color": "Red"});
  }
  // Future<void> 
}
