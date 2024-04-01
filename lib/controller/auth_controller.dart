import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/pages/auth/signIn_page.dart';
import 'package:firebase_flutter/pages/home/home_page.dart';
import 'package:firebase_flutter/widget/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  late TextEditingController emailC, passwordC;

  /// Baris `late Rx<User?> _user = Rx<User?>(null);` membuat variabel reaktif bertipe `_user`
  /// `Rx<User?>` yang akan digunakan untuk mengamati perubahan status otentikasi pengguna. Kelas `Rx` adalah
  /// disediakan oleh paket GetX di Flutter dan digunakan untuk pemrograman reaktif.
  late Rx<User?> _user =
      Rx<User?>(null); // Tambahkan Rx untuk mengamati perubahan User

  @override
  void onInit() {
    super.onInit();
    emailC = TextEditingController();
    passwordC = TextEditingController();

    ///Baris `_user.bindStream(auth.authStateChanges());` mengikat variabel reaktif `_user`
    /// ke aliran yang dikembalikan oleh `auth.authStateChanges()`. Artinya setiap kali ada perubahan
    /// dalam status autentikasi (misalnya, pengguna masuk atau keluar), variabel `_pengguna` akan menjadi
    /// diperbarui dengan informasi otentikasi pengguna baru. Hal ini memungkinkan aplikasi untuk bereaksi secara reaktif
    /// merespons perubahan status autentikasi tanpa perlu memperbarui `_pengguna` secara manual
    /// variabel.
    _user.bindStream(
        auth.authStateChanges()); // Menghubungkan _user dengan authStateChanges
  }

  @override
  void onClose() {
    super.onClose();
    emailC.dispose();
    passwordC.dispose();
  }

  Stream<User?> get authStateChanges => auth.authStateChanges();

  Future<void> signIn({required String email, required String password}) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (myUser.user!.emailVerified) {
        Get.off(
            () => HomePage()); // Menggunakan Get.off untuk mengganti halaman
      } else {
        print('Please verify your account');
        AlertDialog().alertdialog(titletxt: "Verication Email", midtxt: "");
      }
    } catch (e) {
      // Handle login errors
      print('Error logging in: $e');
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await myUser.user!.sendEmailVerification();
      AlertDialog().alertdialog(
          titletxt: "Verication Email",
          midtxt: 'Kami telah mengirim verivikasi ke $email',
          onpressed: () {
            Get.back();
            Get.back();
          },
          confirmtxt: "okee");
    } catch (e) {
      print("Eerror r : ${e}");
    }
  }

  Future<void> resetPassword({required String email}) async {
    if (email == null && GetUtils.isEmail(email)) {
      AlertDialog().alertdialog(
          titletxt: "Terjadi kesalahan", midtxt: 'tidak dapat mengirim' ,onpressed: () {
            Get.back();
            Get.back();
          },);
    }
    {
      try {
        await auth.sendPasswordResetEmail(email: email);
        AlertDialog().alertdialog(
            titletxt: "Berhasil",
            midtxt: 'Telah mengirim reset passsword',
            confirmtxt: 'DONE bang');
      } catch (e) {
        print(e);
      }
    }
  }

  void logout() async {
    try {
      await auth.signOut();
      Get.offAll(
          () => SignInPage()); // Menggunakan Get.offAll untuk mengganti halaman
    } catch (e) {
      print(e);
    }
  }
}
