import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/data/database/hive_db.dart';
import 'package:firebase_authentication/screens/auth/ui/login_page.dart';
import 'package:firebase_authentication/screens/products/ui/home_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Rx<User> _firebaseUser = Rx<User>(null);

  @override
  void onInit() {
    super.onInit();

    _firebaseUser.bindStream(_firebaseAuth.authStateChanges());
    // print("Current AUTH:   ${_firebaseAuth.currentUser}");
  }

  /// ! CREATE USER
  RxBool regLoader = RxBool(false);
  void createUser({String email, String password, String dateOfBirth}) async {
    try {
      regLoader(true);
      var data = FirebaseFirestore.instance.collection("Users");
      Map<String, String> userdata = {
        "Email address": email,
        "Password": password,
        "DateOfBirth": dateOfBirth
      };
      var register = _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (register != null) {
        data.add(userdata).then((value) => Get.back());
        Get.snackbar(
          "Account Created",
          "Please login to continue",
        );
      }
    } catch (e) {
      Get.snackbar("Error while creating account ", e.toString());
    } finally {
      regLoader(false);
    }
  }

  //! LOGIN
  RxBool loginLoader = RxBool(false);
  void login(String email, String password) async {
    try {
      loginLoader(true);
      var data = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (data != null) {
        Get.offAll(HomePage());
        HiveX.setUserId(data.user.uid);
      }
    } on PlatformException {
      Get.snackbar("Error while sign in ", "Check your email and password");
    } catch (e) {
      Get.snackbar(
        "Error while sign in ",
        e.toString(),
      );
    } finally {
      loginLoader(false);
    }
  }

  //! SIGNOUT
  void signout() async {
    try {
      await _firebaseAuth.signOut();
      HiveX.setUserId(null);
      Get.offAll(() => LoginPage());
    } catch (e) {
      print(e.toString());
    }
  }
}
