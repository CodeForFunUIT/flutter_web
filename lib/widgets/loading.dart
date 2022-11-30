import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loading {
  // this is where you would do your fullscreen loading
  static Future<void> startLoading(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  static Future<void> stopLoading() async {
    Get.back();
  }
}
