import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/pages/auth/signIn_page.dart';
import 'package:firebase_flutter/pages/home/home_page.dart';
import 'package:firebase_flutter/widget/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  late TextEditingController emailC, passwordC;
  late Rx<User?> _user = Rx<User?>(null); // Tambahkan Rx untuk mengamati perubahan User

  @override
  void onInit() {
    super.onInit();
    emailC = TextEditingController();
    passwordC = TextEditingController();
    _user.bindStream(auth.authStateChanges()); // Menghubungkan _user dengan authStateChanges
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
        Get.off(() => HomePage()); // Menggunakan Get.off untuk mengganti halaman
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
      UserCredential myUser = await auth.createUserWithEmailAndPassword(email: email, password: password);
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

  void logout() async {
    try {
      await auth.signOut();
      Get.offAll(() => SignInPage()); // Menggunakan Get.offAll untuk mengganti halaman
    } catch (e) {
      print(e);
    }
  }
}
