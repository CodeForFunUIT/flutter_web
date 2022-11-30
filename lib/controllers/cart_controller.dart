import 'package:flutter_web_electronic_components/constants/link.dart';
import 'package:flutter_web_electronic_components/models/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();

  List<CartDetail?> _carts = [];
  List<CartDetail?> get carts => _carts;
  set carts(List<CartDetail?> data) {
    _carts = [...data];
    update();
  }

  Future<void> addToCart({
    String? idUser,
    String? idProduct,
    String? number,
  }) async {
    final body = jsonEncode({
      'email': idUser,
      'password': idProduct,
      'number': number,
    });
    try {
      http.Response res = await http.post(
        Uri.parse(Domain.addToCart),
        body: body,
      );

      if (res.statusCode == 200) {
        carts = (jsonDecode(res.body) as List)
            .map((e) => CartDetail.fromJson(e))
            .toList();
      } else {
        print('email exist');
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
