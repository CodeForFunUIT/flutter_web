import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/controllers/auth_controller.dart';
import 'package:flutter_web_electronic_components/controllers/cart_controller.dart';
import 'package:flutter_web_electronic_components/controllers/navigator_controller.dart';
import 'package:flutter_web_electronic_components/controllers/product_controller.dart';
import 'package:flutter_web_electronic_components/layout.dart';
import 'package:flutter_web_electronic_components/pages/404/page_not_found.dart';
import 'package:flutter_web_electronic_components/pages/auth/login.dart';
import 'package:flutter_web_electronic_components/pages/auth/register.dart';
import 'package:flutter_web_electronic_components/pages/detail/detail_page_dev.dart';

import 'package:get/get.dart';

void main() {
  // Get.put(MenuController());
  Get.put(NavigationController());
  Get.put(ProductController());
  Get.put(AuthController());
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: registerPage,
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const PageNotFound(),
        transition: Transition.fadeIn,
      ),
      getPages: [
        GetPage(
          name: rootRoute,
          page: () {
            return SiteLayout();
          },
        ),
        GetPage(
          name: detailPageDEV,
          page: () => const DetailPageDEV(),
        ),
        GetPage(
          name: loginPage,
          page: () => const Login(),
        ),
        GetPage(
          name: registerPage,
          page: () => const Register(),
        ),
      ],
      // onGenerateRoute: ,
      debugShowCheckedModeBanner: false,
      title: 'Dash',
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        appBarTheme: AppBarTheme(backgroundColor: blue),
        // colorScheme: ColorScheme(primary: blue,brightness: ThemeData.) ,
        // textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
        //     .apply(bodyColor: Colors.black),
        primaryColor: Colors.blue,
      ),
      home: SiteLayout(),
    );
  }
}
