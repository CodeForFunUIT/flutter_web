import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/models/product.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/item_card.dart';

class GridProduct extends StatelessWidget {
  final List<Product> products;
  final double widthItem;
  final double height;
  final double runSpacing;
  final String titleText;
  const GridProduct({
    super.key,
    required this.products,
    required this.widthItem,
    required this.height,
    required this.titleText,
    this.runSpacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        title(context),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: list(),
        ),
        // if (products.length >= 5) ...[
        //   const SizedBox(height: 16),
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: list(5),
        //   ),
        //   const SizedBox(height: 16),
        //   if (products.length >= 10) xemThem(),
        // ]
      ],
    );
    // SizedBox(
    //   height: height,
    //   child: GridView.builder(
    //     scrollDirection: Axis.horizontal,
    //     itemBuilder: (_, index) {
    //       return ItemCard(
    //         height: 100,
    //         width: widthItem,
    //         product: products[index],
    //       );
    //     },
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       childAspectRatio: 2,
    //     ),
    //     itemCount: products.length,
    //   ),
    // );
  }

  List<Widget> list([int start = 0]) {
    return List.generate(
      products.length >= 5 && start == 0
          ? 5
          : products.length > 10
              ? 5
              : products.length - start,
      (index) => ItemCard(
        height: height,
        width: widthItem,
        product: products[index + start],
      ),
    );
  }

  Widget title(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: blue,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.3,
          vertical: 16,
        ),
        child: CustomText(
          text: titleText,
          size: 16,
          weight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget xemThem() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        side: BorderSide(color: blue),
      ),
      onPressed: () {},
      child: RichText(
        text: TextSpan(
          text: 'Xem thêm sản phẩm',
          style: TextStyle(color: blue),
          children: [
            TextSpan(
              text: titleText,
              style: TextStyle(color: blue, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
