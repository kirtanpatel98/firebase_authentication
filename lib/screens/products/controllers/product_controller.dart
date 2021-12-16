import 'package:firebase_authentication/data/database/firebase_db.dart';
import 'package:firebase_authentication/data/models/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxList<ProductModel> productsList = RxList<ProductModel>([]);

  RxBool newsLoader = RxBool(true);
  @override
  void onInit() {
    super.onInit();
    productsList.bindStream(FirebaseInstance.getProductsStream());
  }
}
