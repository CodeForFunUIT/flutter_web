import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/pages/home/home_page.dart';
import 'package:flutter_web_electronic_components/widgets/footer.dart';
import 'package:flutter_web_electronic_components/widgets/image_slider.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/product_controller.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: GetBuilder<ProductController>(
              initState: (_) => productController.getBanners(),
              builder: (controller) => controller.banners.isEmpty
                  ? Shimmer.fromColors(
                      baseColor: baseShimmerColor,
                      highlightColor: highlightShimmerColor,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height * .7,
                        height: MediaQuery.of(context).size.height * .6,
                      ),
                    )
                  : ImageSlider(
                      images: controller.banners.map((e) => e.image!).toList(),
                      height: MediaQuery.of(context).size.height * .6,
                    ),
            ),
          );
        }
        if (index == 1) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: HomePage(),
          );
        }
        return const Footer();
      },
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      shrinkWrap: true,
      itemCount: 3,
    );
  }
}
