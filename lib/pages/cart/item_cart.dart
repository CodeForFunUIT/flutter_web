import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/models/cart.dart';
import 'package:flutter_web_electronic_components/widgets/custom_image.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/item_card.dart';

class ItemCart extends StatelessWidget {
  final CartDetail cart;
  const ItemCart({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomImage(image: cart.image!, height: 100, width: 100),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: cart.name,
                      maxLines: 1,
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: (double.parse(cart.price!) *
                                  int.parse(cart.number!))
                              .toVND(),
                          color: Colors.grey,
                        ),
                        // UpDownButtonCart(callBack: (number) {}),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: CustomText(text: cart.number),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () {
                cartController.deleteCarts(cart: cart);
              },
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: CustomText(
                  text: 'Xóa',
                  color: Colors.white,
                  size: 8,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
