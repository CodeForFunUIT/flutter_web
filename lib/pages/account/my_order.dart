import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/controllers/cart_controller.dart';
import 'package:flutter_web_electronic_components/controllers/navigator_controller.dart';
import 'package:flutter_web_electronic_components/pages/account/order_info.dart';
import 'package:flutter_web_electronic_components/widgets/app_bar.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/footer.dart';
import 'package:get/get.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 48),
        child: Column(
          children: [
            const CustomText(
              text: 'Tài khoản của bạn',
              size: 24,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 24),
            const ColoredBox(
              color: Colors.black,
              child: SizedBox(width: 50, height: 4),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ColoredBox(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: 'Tài khoản',
                            weight: FontWeight.bold,
                            size: 18,
                          ),
                          const SizedBox(height: 24),
                          const CustomText(
                            text: 'Thông tin tài khoản',
                          ),
                          const SizedBox(height: 24),
                          const CustomText(
                            text: 'Thông tin order',
                          ),
                          const SizedBox(height: 24),
                          InkWell(
                            onTap: () {
                              authController.logout();
                              Get.offAllNamed(rootRoute);
                            },
                            child: const CustomText(
                              text: 'Đăng xuất',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      children: [
                        thongTinTaiKhoan(),
                        const SizedBox(height: 24),
                        donHang(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget thongTinTaiKhoan() {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Thông tin tài khoản',
              size: 18,
              weight: FontWeight.bold,
            ),
            const Divider(height: 24),
            CustomText(
              text:
                  '${authController.user!.firstName} ${authController.user!.lastName}',
            ),
            const SizedBox(height: 8),
            CustomText(text: authController.user!.email),
            const SizedBox(height: 8),
            CustomText(text: authController.user!.dateOfBirth),
            const SizedBox(height: 8),
            CustomText(text: authController.user!.phone),
          ],
        ),
      ),
    );
  }

  Widget donHang() {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 24),
        child: Column(
          children: [
            const CustomText(
              text: 'DANH SÁCH ĐƠN HÀNG MỚI NHẤT',
              weight: FontWeight.bold,
              size: 16,
            ),
            const Divider(height: 16),
            GetBuilder<CartController>(
              initState: (_) =>
                  cartController.getOrder(idUser: authController.user!.id),
              builder: (controller) => controller.orders.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return OrderInfor(
                          order: controller.orders[index],
                          isTitle: index == 0,
                        );
                      },
                      separatorBuilder: (_, index) {
                        return const Divider(height: 24);
                      },
                      itemCount: controller.orders.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
