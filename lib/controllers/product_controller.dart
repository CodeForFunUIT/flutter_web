import 'dart:convert';

import 'package:flutter_web_electronic_components/models/banner.dart';
import 'package:flutter_web_electronic_components/models/product_detail.dart';
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

  List<Product> _cpus = [];
  List<Product> get cpus => _cpus;
  set cpus(List<Product> data) {
    _cpus.clear();
    _cpus = [...data];
    update();
  }

  List<Product> _laptops = [];
  List<Product> get laptops => _laptops;
  set laptops(List<Product> data) {
    _laptops.clear();
    _laptops = [...data];
    update();
  }

  List<Product> _allProducts = [];
  List<Product> get allProducts => _allProducts;
  set allProducts(List<Product> data) {
    _allProducts.clear();
    _allProducts = [...data];
    update();
  }

  List<Banner> _banners = [];
  List<Banner> get banners => _banners;
  set banners(List<Banner> data) {
    _banners.clear();
    _banners = [...data];
    update();
  }

  ProductDetail? _detail;
  ProductDetail? get detail => _detail;
  set detail(ProductDetail? data) {
    _detail = data;
    update();
  }

  void init() {}

  Future<void> getProduct({String? idProductType}) async {
    final body = jsonEncode({
      "idProductType": idProductType,
    });
    try {
      if (idProductType == null) {
        http.Response res = await http.post(
          Uri.parse(Domain.getProduct),
        );
        if (res.statusCode == 200) {
          allProducts = (jsonDecode(res.body) as List)
              .map(
                (item) => Product.fromJson(item),
              )
              .toList();
        }
      } else {
        http.Response res = await http.post(
          Uri.parse(Domain.getProduct),
          body: body,
        );
        if (res.statusCode == 200) {
          switch (idProductType) {
            case '1':
              cpus = (jsonDecode(res.body) as List)
                  .map(
                    (item) => Product.fromJson(item),
                  )
                  .toList();
              break;
            case '2':
              products = (jsonDecode(res.body) as List)
                  .map(
                    (item) => Product.fromJson(item),
                  )
                  .toList();
              break;
            case '6':
              laptops = (jsonDecode(res.body) as List)
                  .map(
                    (item) => Product.fromJson(item),
                  )
                  .toList();
              break;
            default:
          }
        } else {}
      }
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

  Future<void> getDetailProduct(String idProduct) async {
    try {
      final body = jsonEncode({
        "idProduct": idProduct,
      });

      http.Response res = await http.post(
        Uri.parse(Domain.getDetailProduct),
        body: body,
      );

      if (res.statusCode == 200) {
        detail = ProductDetail.fromJson(jsonDecode(res.body));
      } else {
        print('err');
      }
    } catch (err) {
      printError(info: err.toString());
    }
  }
}
