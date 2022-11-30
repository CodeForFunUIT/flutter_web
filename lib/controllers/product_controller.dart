import 'dart:convert';

import 'package:flutter_web_electronic_components/models/banner.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_web_electronic_components/constants/link.dart';
import 'package:flutter_web_electronic_components/models/product.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();

  List<Product> _products = [];
  List<Product> get products => _products;
  set products(List<Product> data) {
    _products.clear();
    _products = [...data];
    update();
  }

  List<Banner> _banners = [];
  List<Banner> get banners => _banners;
  set banners(List<Banner> data) {
    _banners.clear();
    _banners = [...data];
    update();
  }

  void init() {}

  Future<void> getProduct({String? idProductType}) async {
    final body = jsonEncode({
      "idProductType": idProductType,
    });
    try {
      http.Response res = await http.post(
        Uri.parse(Domain.getProduct),
        body: body,
      );

      if (res.statusCode == 200) {
        products = (jsonDecode(res.body) as List)
            .map(
              (item) => Product.fromJson(item),
            )
            .toList();
      } else {}
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<void> getBanners() async {
    try {
      http.Response res = await http.get(
        Uri.parse(Domain.getBanner),
      );

      if (res.statusCode == 200) {
        banners = (jsonDecode(res.body) as List)
            .map(
              (item) => Banner.fromJson(item),
            )
            .toList();
      } else {}
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<void> getDetailProduct(int idProductType) async {
    try {
      final body = jsonEncode({
        "idProductType": idProductType,
      });

      http.Response res = await http.post(
        Uri.parse(Domain.getDetailProduct),
        body: body,
      );

      if (res.statusCode == 200) {
        products = (res.body as List)
            .map(
              (item) => Product.fromJson(item),
            )
            .toList();
      } else {}
    } catch (err) {
      printError(info: err.toString());
    }
  }
}
