import 'package:firebase_authentication/data/controllers/firebase_controller.dart';
import 'package:firebase_authentication/data/theme/app_theme.dart';
import 'package:firebase_authentication/screens/cart/controllers/cart_controller.dart';
import 'package:firebase_authentication/screens/cart/ui/cart_page.dart';
import 'package:firebase_authentication/screens/products/controllers/product_controller.dart';
import 'package:firebase_authentication/screens/products/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  final FirebaseController firebaseController = Get.find<FirebaseController>();
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          "Ebizz Shop",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(() => CartPage());
                },
                tooltip: "View Cart",
                icon: Icon(
                  Icons.shopping_bag_rounded,
                  color: Colors.white,
                ),
              ),
              Obx(
                () => Visibility(
                  visible: cartController.cartList.length != 0,
                  child: Positioned(
                    right: 5.0,
                    child: Container(
                      height: 20.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.accentColor,
                      ),
                      child: Center(
                        child: Text(
                          cartController.cartList.length.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              firebaseController.signout();
            },
            tooltip: "Logout",
            icon: Icon(
              Icons.login_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetX<ProductController>(
              init: ProductController(),
              initState: (_) {},
              builder: (controller) {
                if (controller.productsList.length == 0) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.productsList.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      productModel: controller.productsList[index],
                      isFav: controller.productsList[index].isFav,
                      onCart: () {
                        cartController.addTocart(
                          productModel: controller.productsList[index],
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
