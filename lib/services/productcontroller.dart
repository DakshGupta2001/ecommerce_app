import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/ProductsModel.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  static ProductsController instance = Get.find();
  RxList<ProductsModel> products =
      RxList<ProductsModel>([]);
  String collection = "Products";
  List<ProductsModel> get models => products.value;
  @override
  onReady() {
    super.onReady();
    print("doin");
    products.bindStream(getAllProducts());
    print(models);
  }

  Stream<List<ProductsModel>> getAllProducts() =>
      FirebaseFirestore.instance
          .collection(collection)
          .snapshots()
          .map((query) => query.docs
              .map((item) =>
                  ProductsModel.fromMap(item.data()))
              .toList());
}
