import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/base/enum.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/controllers/navigator_controller.dart';
import 'package:flutter_web_electronic_components/models/cart.dart';
import 'package:flutter_web_electronic_components/pages/orders/payment_method_page.dart';
import 'package:flutter_web_electronic_components/widgets/app_bar.dart';
import 'package:flutter_web_electronic_components/widgets/custom_dialog.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/footer.dart';
import 'package:flutter_web_electronic_components/widgets/loading.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  final FromWhere fromWhere;
  final List<CartDetail?> carts;
  const Login({
    super.key,
    this.fromWhere = FromWhere.fromLoginNormal,
    this.carts = const [],
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController email;
  late TextEditingController password;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      Loading.startLoading(context);
      await authController.login(
        email: email.text,
        password: password.text,
      );
      // if (authController.user != null) {
      //   await cartController.getCart(idUser: authController.user?.id);
      // }
      Loading.stopLoading();
      if (authController.user == null) {
        Get.dialog(const CustomDialog(type: DialogType.loginFail));
      } else {
        switch (widget.fromWhere) {
          case FromWhere.fromLoginNormal:
            Get.back();
            break;
          case FromWhere.fromBuyProduct:
            Get.to(
              const PaymentMethodPage(),
            );
            break;
          default:
        }
      }
    } else {
      print('error');
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Không được bỏ trống';
    }

    return null;
  }

  String? validateEmail(String? value) {
    final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (value == null || value.isEmpty || !emailValid.hasMatch(value)) {
      return 'email Không hợp lệ';
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
                            text: 'Đăng nhập',
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
                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                              hintText: 'Nhập email',
                              labelText: 'Email',
                              fillColor: Colors.grey[300],
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (validateEmpty(value) != null) {
                                return validateEmpty(value);
                              }
                              return validateEmail(value);
                            },
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: password,
                            decoration: const InputDecoration(
                              hintText: 'Nhập mật khẩu',
                              labelText: 'password',
                              fillColor: Colors.grey,
                              border: OutlineInputBorder(),
                            ),
                            validator: validateEmpty,
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
                                onPressed: login,
                                child: const CustomText(
                                  text: 'Đăng nhập',
                                  weight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 24),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(registerPage);
                                },
                                child: CustomText(text: 'Đăng ký', color: blue),
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
