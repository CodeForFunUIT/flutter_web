import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/controllers/product_controller.dart';
import 'package:flutter_web_electronic_components/pages/home/home_page.dart';
import 'package:flutter_web_electronic_components/widgets/image_slider.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Column(
        children: const [
          // GetBuilder<ProductController>(
          //   initState: (_) => productController.getBanners(),
          //   builder: (controller) => controller.banners.isEmpty
          //       ? Shimmer.fromColors(
          //           baseColor: baseShimmerColor,
          //           highlightColor: highlightShimmerColor,
          //           child: ImageSlider(
          //             images: controller.banners.map((e) => e.image!).toList(),
          //             height: MediaQuery.of(context).size.height * .73,
          //           ),
          //         )
          //       : ImageSlider(
          //           images: controller.banners.map((e) => e.image!).toList(),
          //           height: MediaQuery.of(context).size.height * .73,
          //         ),
          // ),
          SizedBox(height: 24),
          HomePage(),
        ],
      ),
    );
  }
}
