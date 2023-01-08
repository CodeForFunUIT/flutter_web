import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/base/enum.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/controllers/navigator_controller.dart';
import 'package:flutter_web_electronic_components/pages/auth/login.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final DialogType type;
  const CustomDialog({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: caseDialog(context),
    );
  }

  Widget caseDialog(BuildContext context) {
    switch (type) {
      case DialogType.loginFail:
        return loginFail();
      case DialogType.emptyCart:
        return emptyCart(context);
      case DialogType.mustLogin:
        return mustLogin(context);
      case DialogType.addCartSuccess:
        return addCartSuccess();
      case DialogType.logout:
        return logout();
      case DialogType.addOrderSuccess:
        return addOrderSuccess();
    }
  }

  Widget loginFail() {
    return dialog(
      title: 'Đăng nhập thất bại',
      content: 'Mật khẩu hoặc tài khoản không tồn tại',
      button: ElevatedButton(
        onPressed: () => Get.back(),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomText(
            text: 'Xác nhận',
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget emptyCart(BuildContext context) {
    return dialog(
      title: 'Giỏ hàng của bạn đang rỗng',
      content: 'Di chuyển đến trang chủ để mua sản phẩm?',
      button: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  surfaceTintColor: Colors.blue,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomText(
                    text: 'Hủy',
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Get.offAllNamed(rootRoute),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomText(
                    text: 'Xác nhận',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mustLogin(BuildContext context) {
    return dialog(
      title: 'Bạn cần phải đăng nhập để mua sản phẩm',
      content: 'Di chuyển đến trang đăng nhập?',
      button: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomText(
                    text: 'Hủy',
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Get.to(
                  Login(
                    fromWhere: FromWhere.fromBuyProduct,
                    carts: cartController.carts,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomText(
                    text: 'Xác nhận',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addCartSuccess() {
    return dialog(
      title: 'Thành công',
      content: 'Đã thêm sản phẩm vào giỏ hàng của bạn',
      button: ElevatedButton(
        onPressed: () => Get.back(),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomText(
            text: 'Xác nhận',
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget addOrderSuccess() {
    String date =
        '${DateTime.now().add(const Duration(days: 2)).day}/${DateTime.now().add(const Duration(days: 2)).month}/${DateTime.now().add(const Duration(days: 2)).year}';
    return dialog(
      title: 'Thành công',
      content:
          "Đơn hàng của bạn đã tiếp nhận \n quý khách vui lòng đến trước ngày $date để thanh toán",
      button: ElevatedButton(
        onPressed: () => Get.offAllNamed(rootRoute),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomText(
            text: 'Xác nhận',
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget logout() {
    return dialog(
      title: 'Đăng xuất',
      content: 'Đăng xuất thành công',
      button: ElevatedButton(
        onPressed: () => Get.back(),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomText(
            text: 'Xác nhận',
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget dialog({
    required String title,
    required String content,
    required Widget button,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: title,
            weight: FontWeight.bold,
            size: 20,
          ),
          const SizedBox(height: 24),
          CustomText(
            text: content,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          button,
        ],
      ),
    );
  }
}
