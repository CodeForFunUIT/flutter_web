import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/controllers/auth_controller.dart';
import 'package:flutter_web_electronic_components/controllers/navigator_controller.dart';
import 'package:flutter_web_electronic_components/models/user.dart';
import 'package:flutter_web_electronic_components/widgets/app_bar.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/footer.dart';
import 'package:flutter_web_electronic_components/widgets/loading.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late TextEditingController password;
  late TextEditingController rePassword;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    rePassword = TextEditingController();
    password = TextEditingController();
  }

  Future<void> changePassword() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        id: authController.user!.id,
        firstName: authController.user!.firstName,
        lastName: authController.user!.lastName,
        sex: authController.user?.sex ?? '',
        email: authController.user!.email,
        password: password.text,
        dateOfBirth: authController.user!.dateOfBirth,
        phone: authController.user!.phone,
      );
      Loading.startLoading(context);
      await authController.changePassword(user: user);
      Loading.stopLoading();
      Get.offAllNamed(rootRoute);
    } else {
      print('error');
    }
  }

  @override
  void dispose() {
    rePassword.dispose();
    password.dispose();
    super.dispose();
  }

  String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Không được bỏ trống';
    }

    return null;
  }

  String? checkRePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Không được bỏ trống';
    }
    if (value != password.text) {
      return 'mật khẩu không trùng khớp';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: ColoredBox(
                color: Colors.white,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const CustomText(
                            text: 'Đổi mật khẩu',
                            weight: FontWeight.bold,
                          ),
                          const SizedBox(height: 16),
                          const SizedBox(
                            width: 100,
                            child: Divider(
                              thickness: 3,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 24),
                          GetBuilder<AuthController>(
                            builder: (controller) => TextFormField(
                              controller: password,
                              obscureText:
                                  !controller.passwordVisiblechangePass,
                              decoration: InputDecoration(
                                hintText: 'Nhập mật khẩu mới',
                                labelText: 'Mật khẩu mới',
                                fillColor: Colors.grey[300],
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.passwordVisiblechangePass
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    controller.passwordVisiblechangePass =
                                        !controller.passwordVisiblechangePass;
                                  },
                                ),
                              ),
                              validator: validateEmpty,
                            ),
                          ),
                          const SizedBox(height: 24),
                          GetBuilder<AuthController>(
                            builder: (controller) => TextFormField(
                              controller: rePassword,
                              obscureText:
                                  !controller.passwordVisibleReChangePass,
                              decoration: InputDecoration(
                                hintText: 'Nhập lại mật khẩu mới',
                                labelText: 'Nhập lại mật khẩu mới',
                                fillColor: Colors.grey,
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.passwordVisibleReChangePass
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    controller.passwordVisibleReChangePass =
                                        !controller.passwordVisibleReChangePass;
                                  },
                                ),
                              ),
                              validator: checkRePassword,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 24,
                                  ),
                                  side:
                                      const BorderSide(style: BorderStyle.none),
                                ),
                                onPressed: changePassword,
                                child: const CustomText(
                                  text: 'Đổi mật khẩu',
                                  weight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 24),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(rootRoute);
                                },
                                child:
                                    CustomText(text: 'Trang chủ', color: blue),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
