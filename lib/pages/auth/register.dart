import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/controllers/navigator_controller.dart';
import 'package:flutter_web_electronic_components/models/user.dart';
import 'package:flutter_web_electronic_components/pages/auth/radio_button.dart';
import 'package:flutter_web_electronic_components/widgets/app_bar.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/footer.dart';
import 'package:flutter_web_electronic_components/widgets/loading.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController dateOfBirth;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController sdt;

  final _formKey = GlobalKey<FormState>();
  // final _formKey = GlobalKey<FormState>();
  // final _formKey = GlobalKey<FormState>();
  // final _formKey = GlobalKey<FormState>();
  // final _formKey = GlobalKey<FormState>();

  late User user;
  @override
  void initState() {
    user = User.init();
    super.initState();
    initController();
  }

  void initController() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    password = TextEditingController();
    email = TextEditingController();
    dateOfBirth = TextEditingController();
    sdt = TextEditingController();
  }

  void disposeController() {
    firstName.dispose();
    lastName.dispose();
    dateOfBirth.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  void dispose() {
    disposeController();
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
      return 'Email Không hợp lệ';
    }
    return null;
  }

  String? validatePhoneVietNam(String? value) {
    final phoneValid = RegExp(r"(84|0[3|5|7|8|9])+([0-9]{8})\b");
    if (value == null || value.isEmpty || !phoneValid.hasMatch(value)) {
      return 'Số điện thoại Không hợp lệ';
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
              child: body(),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget body() {
    return ColoredBox(
      color: Colors.white,
      child: SizedBox(
        // height: MediaQuery.of(context).size.height * 1.0,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomText(
                  text: 'Tạo tài khoản',
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
                  controller: firstName,
                  decoration: const InputDecoration(
                    hintText: 'Nhập họ của bạn',
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(),
                    labelText: 'Họ',
                  ),
                  validator: validateEmpty,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: lastName,
                  decoration: const InputDecoration(
                    hintText: 'Nhập tên của bạn',
                    labelText: 'Tên',
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(),
                  ),
                  validator: validateEmpty,
                ),
                const SizedBox(height: 24),
                RadioButton(
                  callBack: (String sex) {
                    user.sex = sex;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: dateOfBirth,
                  decoration: const InputDecoration(
                    hintText: 'Ngày sinh của bạn',
                    labelText: 'dd/mm/yyyy',
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(),
                  ),
                  validator: validateEmpty,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    hintText: 'Nhập email',
                    labelText: 'email',
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(),
                  ),
                  validator: validateEmail,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: password,
                  decoration: const InputDecoration(
                    hintText: 'Nhập mật khẩu',
                    labelText: 'Mật khẩu',
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(),
                  ),
                  validator: validateEmpty,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: sdt,
                  decoration: const InputDecoration(
                    hintText: 'Nhập số điện thoại',
                    labelText: 'Số điện thoại',
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(),
                  ),
                  validator: validatePhoneVietNam,
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
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          user = User(
                            firstName: firstName.text,
                            lastName: lastName.text,
                            email: email.text,
                            sex: user.sex,
                            password: password.text,
                            dateOfBirth: dateOfBirth.text,
                            phone: sdt.text,
                          );
                          Loading.startLoading(context);
                          await authController.register(user: user);
                          Loading.stopLoading();
                          print(authController.user?.id);
                          if (authController.user?.id == null) {
                            Get.snackbar(
                              'Đăng ký thất bại',
                              'Email đã tồn tại',
                              backgroundColor: Colors.red.withOpacity(.6),
                              colorText: Colors.white,
                            );
                          } else {
                            Get.toNamed(rootRoute);
                          }
                        }
                      },
                      child: const CustomText(
                        text: 'Đăng ký',
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 24),
                    InkWell(
                      onTap: () {
                        Get.toNamed(loginPage);
                      },
                      child: CustomText(text: 'Đăng nhập', color: blue),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
