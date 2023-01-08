import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/controllers/product_controller.dart';
import 'package:flutter_web_electronic_components/pages/detail/detail_page.dart';
import 'package:flutter_web_electronic_components/widgets/app_bar.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/footer.dart';
import 'package:flutter_web_electronic_components/widgets/item_card.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AllProductScreen extends StatelessWidget {
  final String title;
  final String idProductType;
  const AllProductScreen({
    super.key,
    required this.title,
    required this.idProductType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 48),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 8, bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: title,
                      weight: FontWeight.bold,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: GetBuilder<ProductController>(
                initState: (_) =>
                    productController.getProduct(idProductType: idProductType),
                builder: (controller) => controller.cpus.isEmpty &&
                        controller.products.isEmpty &&
                        controller.laptops.isEmpty
                    ? Shimmer.fromColors(
                        baseColor: baseShimmerColor,
                        highlightColor: highlightShimmerColor,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.height * .7,
                          height: MediaQuery.of(context).size.height * .6,
                        ),
                      )
                    : Wrap(
                        spacing: 24,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: 24,
                        children: getProduct(context),
                      ),
              ),
            ),
            const SizedBox(height: 24),
            const Footer(),
          ],
        ),
      ),
    );
  }

  List<Widget> getProduct(BuildContext context) {
    switch (idProductType) {
      case '1':
        return List<Widget>.generate(
          productController.cpus.length,
          (index) => InkWell(
            onTap: () => Get.to(
              () => DetailPage(product: productController.cpus[index]),
            ),
            child: ItemCard(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.4,
              product: productController.cpus[index],
            ),
          ),
        );
      case '2':
        return List<Widget>.generate(
          productController.products.length,
          (index) => InkWell(
            onTap: () => Get.to(
              () => DetailPage(product: productController.products[index]),
            ),
            child: ItemCard(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.4,
              product: productController.products[index],
            ),
          ),
        );
      case '6':
        return List<Widget>.generate(
          productController.laptops.length,
          (index) => InkWell(
            onTap: () => Get.to(
              () => DetailPage(product: productController.laptops[index]),
            ),
            child: ItemCard(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.4,
              product: productController.laptops[index],
            ),
          ),
        );
      default:
        return const [];
    }
  }
}
