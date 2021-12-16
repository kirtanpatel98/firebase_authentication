import 'package:firebase_authentication/data/controllers/firebase_controller.dart';
import 'package:firebase_authentication/screens/cart/controllers/cart_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseController>(FirebaseController());

    Get.put<CartController>(CartController());
  }
}
