import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_authentication/data/constants/size_constants.dart';
import 'package:firebase_authentication/data/models/product_model.dart';
import 'package:firebase_authentication/data/theme/app_theme.dart';
import 'package:firebase_authentication/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CartCard extends StatelessWidget {
  final ProductModel productModel;
  final VoidCallback onRemove;
  const CartCard({
    Key key,
    @required this.productModel,
    @required this.onRemove,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(SizeConstant.kDefaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          const BoxShadow(
            offset: const Offset(10, 10),
            blurRadius: 15,
            spreadRadius: 4,
            color: const Color(0xFFE6E6E6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 120.0,
            width: 120.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: productModel.image,
                fit: BoxFit.contain,
                memCacheHeight: 620,
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  productModel.name,
                  style: TextStyle(
                    color: AppTheme.kBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "₹ " + productModel.price,
                  style: TextStyle(
                    color: AppTheme.kBlack,
                    fontSize: 17.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CartButton(
                      title: "Delete",
                      textSize: 16.0,
                      height: 35.0,
                      width: 80.0,
                      onTap: onRemove,
                      isLoading: false,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
