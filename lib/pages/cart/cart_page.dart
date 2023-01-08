import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/base/enum.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/controllers/cart_controller.dart';
import 'package:flutter_web_electronic_components/controllers/navigator_controller.dart';
import 'package:flutter_web_electronic_components/pages/cart/item_cart.dart';
import 'package:flutter_web_electronic_components/widgets/app_bar.dart';
import 'package:flutter_web_electronic_components/widgets/custom_dialog.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/footer.dart';
import 'package:flutter_web_electronic_components/widgets/item_card.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cartController.sumPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: myCart(),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: cartInfo(),
                  ),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget myCart() {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12,
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Giỏ hàng của bạn',
              size: 24,
              weight: FontWeight.bold,
            ),
            const Divider(height: 24),
            GetBuilder<CartController>(
              builder: (controller) => RichText(
                text: TextSpan(
                  text: 'Bạn đang có ',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: '${controller.carts.length} sản phẩm',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: ' trong giỏ hàng',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: GetBuilder<CartController>(
                initState: (_) => cartController.getCart(),
                builder: (controller) => controller.carts.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.separated(
                        itemBuilder: (_, index) => ItemCart(
                          cart: controller.carts[index]!,
                        ),
                        separatorBuilder: (_, index) => const Divider(),
                        shrinkWrap: true,
                        itemCount: controller.carts.length,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cartInfo() {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Thông tin đơn hàng',
              weight: FontWeight.bold,
              size: 24,
            ),
            const SizedBox(height: 24),
            // tong tien
            Row(
              children: [
                const Expanded(
                  child: CustomText(
                    text: 'Tổng tiền:',
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                ),
                GetBuilder<CartController>(
                  // initState: (_) => cartController.sumPrice(),
                  builder: (controller) {
                    return CustomText(
                      text: controller.sum.toVND(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      if (cartController.carts.isEmpty) {
                        Get.dialog(
                          const CustomDialog(type: DialogType.emptyCart),
                        );
                      } else {
                        if (authController.user == null) {
                          Get.dialog(
                            const CustomDialog(type: DialogType.mustLogin),
                          );
                        } else {
                          Get.toNamed(paymentPage);
                        }
                      }
                    },
                    child: const CustomText(
                      text: 'THANH TOÁN',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
