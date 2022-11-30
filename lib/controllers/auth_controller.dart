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
        user = jsonDecode(res.body) as User;
        // Get.offAll(page)
      } else {
        print('email exist');
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<void> register({User? user}) async {
    final body = jsonEncode(user!.toJson());
    try {
      http.Response res = await http.post(
        Uri.parse(Domain.login),
        body: body,
      );

      if (res.statusCode == 200) {
        user = jsonDecode(res.body) as User;
      } else {
        print('email exist');
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
