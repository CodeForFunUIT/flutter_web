import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';

const double spacingSmall = 8;
const double spacingMedium = 12;

class Footer extends StatelessWidget {
  const Footer({super.key});
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Expanded(flex: 4, child: DiaDiemMuaHang()),
            ColumnText(
              title: 'GIỚI THIỆU',
              sub1: 'Giới thiệu',
              sub2: 'Liên hệ',
              sub3: 'Tuyển dụng',
              sub4: 'Trả góp',
            ),
            ColumnText(
              title: 'CHÍNH SÁCH',
              sub1: 'Chính sách bán hàng',
              sub2: 'Chính sách bảo hành',
              sub3: 'Thanh toán',
              sub4: 'Chính sách bảo mật',
            ),
            ColumnText(
              title: 'HỖ TRỢ',
              sub1: 'Hướng dẫn đặt hàng',
              sub2: 'Cộng đồng',
              sub3: 'thn.vn',
              sub4: 'Bảo hành ủy quyền ASUS',
            ),
          ],
        ),
      ),
    );
  }

  Widget gioiThieu() {
    return Column(
      children: const [],
    );
  }
}

class DiaDiemMuaHang extends StatelessWidget {
  const DiaDiemMuaHang({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Địa điểm mua hàng',
          color: Colors.white,
          size: 20,
        ),
        const Divider(
          color: Colors.white,
        ),
        address(
          address: '396 - 398 Nguyễn Kiệm, P. 3, Q. Phú Nhuận, HCM',
          time: ' Thứ 2 - Thứ 6 (9:00 - 20:00)',
        ),
        const SizedBox(height: spacingSmall),
        address(
          address: '55 Chu Mạnh Trinh, P. Bình Thọ, Q. Thủ Đức, HCM',
          time: 'Thứ 2 - Thứ 7 (9:00 - 18:00)',
        ),
        const SizedBox(height: spacingSmall),
        address(
          address: '184/41 Nguyễn Xí, Phường 26, Q. Bình Thạnh, HCM',
          time: 'Thứ 2 - Thứ 6 (8:30 - 17:30)',
        ),
      ],
    );
  }

  Widget address({required String address, required String time}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: address,
          color: Colors.white,
        ),
        const SizedBox(height: spacingSmall),
        Padding(
          padding: const EdgeInsets.only(
            left: 18,
          ),
          child: CustomText(text: time, color: Colors.white),
        ),
        const SizedBox(height: spacingSmall),
        RichText(
          text: const TextSpan(
            text: '📍 ',
            style: TextStyle(fontSize: 16),
            children: [
              TextSpan(
                text: 'Bản đồ đường đi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ColumnText extends StatelessWidget {
  final String title;
  final String sub1;
  final String sub2;
  final String sub3;
  final String sub4;
  const ColumnText({
    super.key,
    required this.title,
    required this.sub1,
    required this.sub2,
    required this.sub3,
    required this.sub4,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: Colors.white,
          size: 20,
        ),
        const Divider(
          color: Colors.white,
        ),
        CustomText(text: sub1, color: Colors.white),
        const SizedBox(height: spacingSmall),
        CustomText(text: sub2, color: Colors.white),
        const SizedBox(height: spacingSmall),
        CustomText(text: sub3, color: Colors.white),
        const SizedBox(height: spacingSmall),
        CustomText(text: sub4, color: Colors.white),
      ],
    );
  }
}
