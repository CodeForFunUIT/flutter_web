import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/models/product.dart';
import 'package:flutter_web_electronic_components/pages/auth/login.dart';
import 'package:flutter_web_electronic_components/pages/auth/register.dart';
import 'package:flutter_web_electronic_components/pages/detail/detail_page.dart';
import 'package:flutter_web_electronic_components/pages/detail/detail_page_dev.dart';
import 'package:flutter_web_electronic_components/pages/home/home_page.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController instance = Get.find();

  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  goBack() => navigationKey.currentState!.pop();
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case detailPage:
      return _getPageRoute(
        DetailPage(
          product: settings.arguments as Product,
        ),
      );
    case detailPageDEV:
      return _getPageRoute(const DetailPageDEV());

    case loginPage:
      return _getPageRoute(const Login());

    case registerPage:
      return _getPageRoute(const Register());

    default:
      return _getPageRoute(const HomePage());
  }
}

const rootRoute = "/";

const detailPage = "/detailPage";
const detailPageDEV = '/detailPageDEV';
const loginPage = "/loginPage";
const registerPage = "/registerPage";

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
