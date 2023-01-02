import 'package:flutter_web_electronic_components/base/enum.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/constants/link.dart';
import 'package:flutter_web_electronic_components/models/cart.dart';
import 'package:flutter_web_electronic_components/models/order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();

  List<Order> _orders = [];
  List<Order> get orders => _orders;
  set orders(List<Order> data) {
    _orders.clear();
    _orders = [...data];
    update();
  }

  List<CartDetail?> _carts = [];
  List<CartDetail?> get carts => _carts;
  set carts(List<CartDetail?> data) {
    _carts.clear();
    _carts = [...data];
    update();
  }

  double _sum = 0;
  double get sum => _sum;
  set sum(double data) {
    _sum = data;
    update();
  }

  int number = 1;

  Future<void> getOrder({String? idUser}) async {
    final body = jsonEncode({
      'idUser': idUser,
    });
    try {
      http.Response res = idUser != null
          ? await http.post(
              Uri.parse(Domain.getOrder),
              body: body,
            )
          : await http.post(
              Uri.parse(Domain.getOrder),
            );

      if (res.statusCode == 200) {
        orders = (jsonDecode(res.body) as List)
            .map((e) => Order.fromJson(e))
            .toList();
      } else {
        print('error');
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<void> getCart() async {
    final prefs = await SharedPreferences.getInstance();

    String? cartPref = prefs.getString(LocalStorage.carts.name);
    if (cartPref != null) {
      // print(cartPref);
      carts = (jsonDecode(cartPref) as List)
          .map((e) => CartDetail.fromJson(e))
          .toList();
      // print(userMap);
    }
  }

  Future<void> addOrder() async {
    List<Map<String, dynamic>> body = [];
    getCart();
    if (_carts.first != null) {
      body = _carts
          .map(
            (e) => {
              "name": e?.name,
              "price": int.parse(e?.price ?? '0'),
              "idUser": int.parse(authController.user!.id!),
              "idProduct": int.parse(e?.idProduct ?? '0'),
              "number": int.parse(e?.number ?? '0'),
              "date":
                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
            },
          )
          .toList();
      print(body);
    }
    try {
      http.Response res = await http.post(
        Uri.parse(Domain.addOrder),
        body: jsonEncode(body),
      );

      if (res.statusCode == 200) {
        print('success');
      } else {
        print('error');
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<void> setCarts({required List<CartDetail?> carts}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LocalStorage.carts.name, jsonEncode(carts));
    update();
  }

  Future<void> addCart({required CartDetail? cart}) async {
    final prefs = await SharedPreferences.getInstance();
    // int index = _carts.indexOf(cart);
    // if (index >= 0) {
    //   _carts[index]!.number = '$number';
    // }
    carts.add(cart);
    await prefs.setString(LocalStorage.carts.name, jsonEncode(carts));
  }

  Future<void> deleteCarts({required CartDetail? cart}) async {
    final prefs = await SharedPreferences.getInstance();
    carts.remove(cart);
    sum -= double.parse(cart!.price!) * int.parse(cart.number!);

    await prefs.setString(LocalStorage.carts.name, jsonEncode(_carts));
  }

  Future<void> removeAllCarts() async {
    final prefs = await SharedPreferences.getInstance();
    carts.clear();
    await prefs.clear();
  }

  Future<void> sumPrice() async {
    getCart();
    sum = carts.fold<double>(
      0,
      (pre, e) => pre + double.parse(e!.price!) * int.parse(e.number!),
    );
  }
}
