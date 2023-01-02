import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/models/product.dart';
import 'package:flutter_web_electronic_components/widgets/custom_image.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class ItemCard extends StatelessWidget {
  final double height;
  final double width;
  final Product product;

  const ItemCard({
    super.key,
    required this.height,
    required this.width,
    required this.product,
  });

  static const double runSpacing = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomImage(
            image: product.image!,
            height: height / 2,
            width: width,
          ),
          // Container(width: 100, height: 100, color: Colors.blue),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CustomText(
              text: product.name,
              size: 16,
              weight: FontWeight.bold,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CustomText(
              text: double.parse(product.price!).toVND(),
              size: 16,
              color: Colors.red,
              weight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

extension FormatCurrencyExt on num {
  String toVND({String locale = 'vi_VN', String symbol = '₫'}) {
    return NumberFormat.currency(
      locale: locale,
      customPattern: '#,##0\u00a4',
      symbol: symbol,
    ).format(this);
  }

  String rutGonTien({String locale = 'vi_VN'}) {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(0)}Tr';
    }
    return '${(this / 1000).toStringAsFixed(0)}K';
  }
}
