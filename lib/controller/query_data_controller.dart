import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QueryDataController extends GetxController {
  final dataQuery = FirebaseFirestore.instance;

  ///To filter documents within a collection, the where method can be chained onto a collection reference.
  ///Filtering supports equality checks and "in" queries. For example, to filter users where their age is greater than 24:
  void filter() async {
    final result = await dataQuery
        .collection("user")
        .where("kendaraan", arrayContains: ["mobil"]).get();
    print(result.docs.length);
  }

  Future<void> limitier() async {
    final result = await dataQuery.collection("user").limit(2).get();
// result.docs: Ini adalah properti dari QuerySnapshot yang berisi daftar dokumen yang ditemukan oleh query di Firestore.
// .map((document) => document.data() as Map<String, dynamic>): Ini adalah metode untuk memetakan setiap dokumen dalam result.docs ke dalam bentuk Map. Kita menggunakan method map untuk iterasi melalui setiap dokumen, dan kemudian untuk setiap dokumen, kita memanggil .data() untuk mendapatkan data dalam bentuk Map<String, dynamic>. Ingatlah bahwa document.data() akan mengembalikan data dari dokumen Firestore dalam bentuk Map<String, dynamic>.
// .toList(): Ini mengonversi hasil pemetaan menjadi List<Map<String, dynamic>>. Dengan kata lain, ini mengubah iterator yang dihasilkan oleh .map() menjadi daftar (List) yang berisi Map<String, dynamic>.
    final List<Map<String, dynamic>> jsonData = result.docs
        .map((document) => document.data() as Map<String, dynamic>)
        .toList();
    print(jsonData);
  }
}
