import 'package:firebase_authentication/data/models/product_model.dart';
import 'package:firebase_authentication/screens/cart/ui/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<ProductModel> cartList = RxList<ProductModel>([]);

  RxInt cartTotal = RxInt(0);
  @override
  void onClose() {
    cartList.clear();
    cartTotal.value = 0;
    super.onClose();
  }

  // !! CALCULATE CART TOTAL
  void calculateTotal() {
    try {
      cartTotal.value = 0;
      for (final ProductModel data in cartList) {
        cartTotal.value += int.parse(data.price.replaceAll(",", ""));
      }
      print(cartTotal.value);
    } catch (e) {
      print(e.toString());
    }
  }

  // !! ADD TO CART
  void addTocart({ProductModel productModel}) {
    try {
      // !! FOR CHECKING IF THAT PRODUCT DOESNT ALREADY EXIST
      if (!cartList.contains(productModel)) {
        cartList.add(productModel);
        Get.snackbar(
          "",
          "",
          titleText: Text(
            "Added to Cart",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          messageText: Text("Success"),
          backgroundColor: Colors.white,
          onTap: (_) {
            Get.to(
              () => CartPage(),
            );
          },
        );
      }
    } catch (e) {
      print(e.toString());
    } finally {
      calculateTotal();
    }
  }

  // !! DELETE CART ELEMENT
  void deleteCartAt({ProductModel productModel}) {
    this.cartList.remove(productModel);
    Get.snackbar(
      "",
      "",
      titleText: Text(
        "Removed from cart",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text("Success"),
      backgroundColor: Colors.white,
      onTap: (_) {
        Get.to(
          () => CartPage(),
        );
      },
    );
  }
}
