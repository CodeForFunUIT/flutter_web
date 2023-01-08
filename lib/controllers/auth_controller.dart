import 'package:flutter_web_electronic_components/constants/link.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_web_electronic_components/models/user.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  User? _user;
  User? get user => _user;
  set user(User? data) {
    _user = User.copyWith(data);
    update();
  }

  Future<void> login({String? email, String? password}) async {
    final body = jsonEncode({
      'email': email,
      'password': password,
    });
    try {
      http.Response res = await http.post(
        Uri.parse(Domain.login),
        body: body,
      );

      if (res.statusCode == 200) {
        user = User.fromJson(jsonDecode(res.body));
      } else {
        print('email exist');
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  void logout({String? email, String? password}) async {
    _user = null;

    update();
  }

  Future<void> register({User? user}) async {
    final body = jsonEncode(user!.toJson(user));
    print(body);
    try {
      http.Response res = await http.post(
        Uri.parse(Domain.register),
        body: body,
      );

      if (res.statusCode == 200) {
        this.user = User.fromJson(jsonDecode(res.body));
        print(this.user?.id);
      } else {
        print('email exist');
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
