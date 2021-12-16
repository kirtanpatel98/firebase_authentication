import 'package:firebase_authentication/data/theme/app_theme.dart';
import 'package:firebase_authentication/screens/cart/controllers/cart_controller.dart';
import 'package:firebase_authentication/screens/cart/widget/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  CartPage({Key key}) : super(key: key);
  final CartController cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.accentColor,
        title: Text(
          "Cart Page",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(right: 10, top: 10),
                    child: RichText(
                      text: TextSpan(
                        text: "Total Amount:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21.0,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " ₹ " + cartController.cartTotal.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () {
                if (cartController.cartList.length == 0) {
                  return const Center(
                    child: const Text(
                      "CART EMPTY",
                      style: const TextStyle(
                        fontSize: 21.0,
                        color: AppTheme.kBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: cartController.cartList.length,
                  itemBuilder: (context, index) {
                    return CartCard(
                      productModel: cartController.cartList[index],
                      onRemove: () {
                        cartController.deleteCartAt(
                          productModel: cartController.cartList[index],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
