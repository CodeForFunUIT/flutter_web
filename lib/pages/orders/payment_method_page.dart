import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/base/enum.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/controllers/cart_controller.dart';
import 'package:flutter_web_electronic_components/controllers/navigator_controller.dart';
import 'package:flutter_web_electronic_components/models/cart.dart';
import 'package:flutter_web_electronic_components/widgets/custom_dialog.dart';
import 'package:flutter_web_electronic_components/widgets/custom_image.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/item_card.dart';
import 'package:flutter_web_electronic_components/widgets/loading.dart';
import 'package:get/get.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 6, child: paymentMethod(context)),
          Expanded(flex: 4, child: detailMethod()),
        ],
      ),
    );
  }

  Widget paymentMethod(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 100.0, right: 50, top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Phương thức thanh toán',
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey),
              ),
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 24),
                      InkWell(
                        onTap: () {
                          Get.dialog(
                            Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CustomText(
                                      text: 'Chưa hỗ trợ chức năng này',
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 24),
                                    const CustomText(
                                      text:
                                          'Quý khách vui lòng chọn phương thức thanh toán khác',
                                    ),
                                    const SizedBox(height: 24),
                                    ElevatedButton(
                                      onPressed: () => Get.back(),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CustomText(
                                          text: 'Xác nhận',
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      const Icon(Icons.account_balance),
                      const SizedBox(width: 8),
                      const CustomText(text: 'Chuyển khoản qua ngân hàng'),
                    ],
                  ),
                  const Divider(height: 48),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 24),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 24),
                      const Icon(Icons.account_balance_wallet),
                      const SizedBox(width: 8),
                      const CustomText(text: 'Thanh toán tại cửa hàng'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(height: 1),
                  Container(
                    color: Colors.grey[100],
                    padding: const EdgeInsets.only(top: 50.0, bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        CustomText(
                          textAlign: TextAlign.center,
                          text:
                              'Quý khách vui lòng đến 1 trong 4 địa chỉ sau để thanh toán trực tiếp tại cửa hàng:',
                          color: Colors.grey,
                          size: 14,
                        ),
                        CustomText(
                          textAlign: TextAlign.center,
                          text:
                              '396-398 Nguyễn Kiệm, P. 3, Q. Phú Nhuận, TP. HCM',
                          color: Colors.grey,
                          size: 14,
                        ),
                        CustomText(
                          textAlign: TextAlign.center,
                          text:
                              '55 Chu Mạnh Trinh, P. Bình Thọ, Q. Thủ Đức, TP. HCM',
                          color: Colors.grey,
                          size: 14,
                        ),
                        CustomText(
                          textAlign: TextAlign.center,
                          text:
                              '41 Đường Số 6, Khu Bắc Đinh Bộ Lĩnh, P. 26, Quận Bình Thạnh, TP. HCM',
                          color: Colors.grey,
                          size: 14,
                        ),
                        CustomText(
                          textAlign: TextAlign.center,
                          text:
                              '204 Nguyễn Văn Tuyết, Trung Liệt, Đống Đa, Hà Nội',
                          color: Colors.grey,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Get.offAllNamed(cartPage);
                  },
                  style:
                      TextButton.styleFrom(foregroundColor: Colors.transparent),
                  child: const CustomText(text: 'Giỏ hàng'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    Loading.startLoading(context);
                    await cartController.addOrder();
                    await cartController.removeAllCarts();
                    Loading.stopLoading();
                    Get.dialog(
                      const CustomDialog(type: DialogType.addOrderSuccess),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.0,
                      horizontal: 16.0,
                    ),
                    child: CustomText(
                      text: 'Hoàn tất đơn hàng',
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

  Widget detailMethod() {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.only(top: 100, left: 50, right: 100),
      child: Column(
        children: [
          GetBuilder<CartController>(
            builder: (controller) => ListView.separated(
              itemBuilder: (_, index) => item(controller.carts[index]),
              shrinkWrap: true,
              separatorBuilder: (_, index) => const SizedBox(height: 8),
              itemCount: controller.carts.length,
            ),
          ),
          const Divider(),
          Row(
            children: [
              const Expanded(child: CustomText(text: 'Tổng cộng')),
              CustomText(
                text: cartController.sum.toVND(),
                size: 24,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget item(CartDetail? cart) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: Colors.grey),
          ),
          child: CustomImage(image: cart!.image!, height: 50, width: 50),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomText(
            text: cart.name,
            maxLines: null,
          ),
        ),
        const SizedBox(width: 24),
        CustomText(text: double.parse(cart.price!).toVND()),
      ],
    );
  }
}
