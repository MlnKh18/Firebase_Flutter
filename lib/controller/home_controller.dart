import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final db = FirebaseFirestore.instance;

  /// Mengambil semua data dari koleksi
  Future<QuerySnapshot> getData() async {
    final user = await db.collection("user").get();
    return user;
  }

  /**
   * Mendapatkan beberapa dokumen dari koleksi
Anda juga dapat mengambil beberapa dokumen dengan satu permintaan, dengan membuat kueri terhadap dokumen dalam koleksi.
Misalnya, Anda dapat menggunakan where() guna membuat kueri untuk semua dokumen yang memenuhi kondisi tertentu,
kemudian menggunakan get() untuk mengambil hasilnya:z
   */
  Future<QuerySnapshot<Object?>> getDataUser() {
    return db.collection("user").where("age", isEqualTo: 23).get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
        return querySnapshot;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  //Get RealTime Data
//   void getDataRealTime() {
//   final docRef = db.collection("cities").doc("SF");
//   docRef.snapshots().listen(
//     (event) {
//       print("current data: ${event.data()}");
//     },
//     onError: (error) {
//       print("Listen failed: $error");
//     },
//   );
// }

Stream<QuerySnapshot<Object?>> getDataRealTime() {
    final docRef = db.collection("user"); // Ganti "user" dengan koleksi yang sesuai
    return docRef.snapshots();
  }
}
