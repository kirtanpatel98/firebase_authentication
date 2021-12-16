import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authentication/data/models/product_model.dart';
import 'package:flutter/material.dart';

class FirebaseInstance {
  static final _instance = FirebaseFirestore.instance;

  static Stream<List<ProductModel>> getProductsStream() {
    return _instance
        .collection('products')
        .snapshots()
        .map((QuerySnapshot query) {
      List<ProductModel> productList = [];
      query.docs.forEach((element) {
        productList.add(ProductModel.fromMap(element.data()));
      });
      return productList;
    });
  }

  static Future<bool> markAsFavorite({
    @required String productID,
    @required bool isFav,
  }) async {
    return _instance
        .collection('produtcs')
        .doc(productID)
        .update({"isFav": isFav}).then((result) {
      return true;
    }).catchError((onError) {
      return false;
    });
  }
}
