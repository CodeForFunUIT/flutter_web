import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/models/product.dart';
import 'package:flutter_web_electronic_components/models/product_detail.dart';
import 'package:flutter_web_electronic_components/widgets/app_bar.dart';
import 'package:flutter_web_electronic_components/widgets/custom_image.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/up_down_button.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  const DetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: CustomImage(
                image: product.image!,
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
            ),
            // Expanded(flex: 6, child: Detail(product: product, detail: ,)),
            const Expanded(
              flex: 6,
              child: ColoredBox(
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  final ProductDetail detail;
  final Product product;
  const Detail({
    super.key,
    required this.detail,
    required this.product,
  });

  static const double runSpacing = 16;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      child: Column(
        children: [
          titleDetail(),
          const Divider(),
          inforCpuDetail(),
        ],
      ),
    );
  }

  Widget titleDetail() {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          CustomText(
            text: product.name,
            size: 24,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: runSpacing),
          Row(
            children: [
              const CustomText(
                text: 'Mã sản phẩm: ',
              ),
              CustomText(text: product.id.toString(), color: blue),
              verticalDivided(),
              const CustomText(
                text: 'Thương hiệu: ',
              ),
              CustomText(text: product.trademark, color: blue),
              verticalDivided(),
              const CustomText(
                text: 'Tình trạng: ',
              ),
              CustomText(
                text: int.parse(product.stock!) > 0 ? 'Còn hàng' : 'Hết hàng',
                color: int.parse(product.stock!) > 0 ? blue : Colors.red,
              ),
            ],
          ),
          const SizedBox(height: runSpacing),
          CustomText(text: '${product.price}đ', size: 24, color: Colors.red),
          const SizedBox(height: runSpacing),
          SizedBox(
            height: 40,
            width: 120,
            child: UpDownButton(callBack: (number) {}),
          ),
          const SizedBox(height: runSpacing),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: blue,
              ),
              child: const CustomText(
                text: 'Mua ngay',
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: runSpacing),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const CustomText(
                text: 'Thêm vào giỏ hàng',
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: runSpacing),
        ],
      ),
    );
  }

  Widget inforCpuDetail() {
    return Column(
      children: [
        const CustomText(text: 'Thông số kỹ thuật'),
        const SizedBox(height: 24),
        rowDetail('Tiến Trình', detail.tienTrinh!),
        rowDetail('Số Nhân', detail.soNhan.toString()),
        rowDetail('Số Luồng', detail.soLuong.toString()),
        rowDetail('Xung nhịp cơ bản', detail.xungNhipCoBan!),
        rowDetail('Xung nhịp tối đa', detail.xungNhipToiDa!),
        rowDetail('Thế Hệ', detail.theHe!),
        rowDetail('Đồ Họa', detail.doHoa!),
      ],
    );
  }

  Widget rowDetail(String name, String detail) {
    return ColoredBox(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(.5),
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColoredBox(
                color: Colors.grey[400]!,
                child: SizedBox(
                  width: 200,
                  child: CustomText(text: name),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 200,
                  child: CustomText(text: detail),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget verticalDivided() {
    return ColoredBox(
      color: lightGrey,
      child: const SizedBox(
        height: 8,
        width: 2,
      ),
    );
  }
}
