import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/models/product.dart';
import 'package:flutter_web_electronic_components/widgets/app_bar.dart';
import 'package:flutter_web_electronic_components/widgets/custom_image.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/item_card.dart';
import 'package:flutter_web_electronic_components/widgets/up_down_button.dart';

class DetailPageDEV extends StatelessWidget {
  const DetailPageDEV({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24),
        shrinkWrap: true,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImage(
                image:
                    'https://tmpfluttermysql.000webhostapp.com/image/ram/Ram%20Crucial%20DDR5%208GB%20Bus%204800MHz%20CL40%20CT8G48C40S5.jpg',
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              const SizedBox(width: 16),
              const Expanded(flex: 1, child: Detail()),
            ],
          ),
          const Divider(height: 24),
          sanPhamDaXem(),
        ],
      ),
    );
  }

  Widget sanPhamDaXem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: CustomText(
            text: 'Sản phẩm đã xem',
            size: 32,
            weight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 300,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ItemCard(
                height: 300,
                width: 200,
                product: Product.dev(),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Detail extends StatelessWidget {
  // final ProductDetail detail;
  // final Product product;
  const Detail({
    super.key,
    // required this.detail,
    // required this.product,
  });

  static const double runSpacing = 16;
  static const double sizeText = 16;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: 64,
        ),
        shrinkWrap: true,
        // padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          // Container(height: 100,width: 100,color: blue)
          titleDetail(),
          const Divider(),
          inforCpuDetail(),
          const Divider(),
          checkRam(),
        ],
      ),
    );
  }

  Widget checkRam() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomText(
          text: 'Kiểm tra laptop có bị thiếu RAM hay không?',
          size: 24,
          color: blue,
        ),
        const SizedBox(height: 32),
        Image.asset(
          'assets/images/check_ram.png',
          fit: BoxFit.fill,
          // width: double.infinity,
        ),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            text: 'Bước 1: Nhấp chuột phải vào thanh ',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: sizeText,
            ),
            children: [
              TextSpan(
                text: 'Taskbar',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: blue,
                  fontSize: sizeText,
                ),
              ),
              const TextSpan(
                text: '-> chọn ',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: sizeText,
                ),
              ),
              TextSpan(
                text: 'Task Manager',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: blue,
                  fontSize: sizeText,
                ),
              ),
              const TextSpan(
                text: '.',
                style: TextStyle(
                  fontSize: sizeText,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Image.asset(
          'assets/images/check_ram2.png',
          fit: BoxFit.fill,
          // width: double.infinity,
        ),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            text: 'Bước 2: Chọn “',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: sizeText,
            ),
            children: [
              const TextSpan(
                text: 'Performance',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: sizeText,
                  color: Colors.red,
                ),
              ),
              const TextSpan(
                text: '” trong ',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: sizeText,
                ),
              ),
              TextSpan(
                text: 'Task Manager',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: sizeText,
                  color: blue,
                ),
              ),
              const TextSpan(
                text: '.',
                style: TextStyle(
                  fontSize: sizeText,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const CustomText(
          text: 'Bước 3: Kiểm tra xem mục “Memory” đã đầy hay chưa.',
          style: FontStyle.italic,
        ),
        const SizedBox(height: 24),
        const CustomText(
          text:
              'Nếu “Memory” hiện trên 80% trong thời gian dài và không mở tác vụ nặng, thì laptop của bạn đang trong tình trạng thiếu RAM hệ thống.',
          maxLines: null,
        ),
        const SizedBox(height: 24),
        const CustomText(
          text:
              'Một điều đặc biệt lưu ý là mục “Slots used” cũng cần xem xét cẩn trọng trong việc nâng cấp RAM. Nếu hiện mức “1 of 2” thì máy chỉ mới sử dụng 1 khe RAM, có thể gắn thêm 1 khe nữa, còn “1 of 1” có nghĩa là máy chỉ có 1 khe RAM.',
          maxLines: null,
        ),
      ],
    );
  }

  Widget titleDetail() {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'product.name',
            size: 24,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: runSpacing),
          Row(
            children: [
              const Flexible(
                child: CustomText(
                  text: 'Mã sản phẩm: ',
                ),
              ),
              Flexible(
                child: CustomText(text: 'product.id', color: blue),
              ),
              verticalDivided(),
              const Flexible(
                child: CustomText(
                  text: 'Thương hiệu: ',
                ),
              ),
              Flexible(
                child: CustomText(text: 'product.trademark', color: blue),
              ),
              verticalDivided(),
              const CustomText(
                text: 'Tình trạng: ',
              ),
              Flexible(
                child: CustomText(
                  // text: int.parse(product.stock!) > 0 ? 'Còn hàng' : 'Hết hàng',
                  text: 'Còn hàng',
                  // color: int.parse(product.stock!) > 0 ? blue : Colors.red,
                  color: blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: runSpacing),
          const CustomText(
            text: 'product.price}đ',
            size: 24,
            color: Colors.red,
          ),
          const SizedBox(height: runSpacing),
          SizedBox(
            height: 40,
            // width: 150,
            child: UpDownButton(callBack: (number) {}),
          ),
          const SizedBox(height: runSpacing),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CustomText(
                          text: 'Mua ngay',
                          size: 18,
                          color: Colors.white,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(height: 4),
                        CustomText(
                          text: 'Nhận tại cửa hàng',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: runSpacing),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: blue,
                    ),
                  ),
                  child: CustomText(
                    text: 'Thêm vào giỏ hàng',
                    color: blue,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: runSpacing),
        ],
      ),
    );
  }

  Widget inforCpuDetail() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Thông số kỹ thuật',
          weight: FontWeight.bold,
          size: 24,
        ),
        const SizedBox(height: 24),
        rowDetail('Tiến Trình', 'detail.tienTrinh!'),
        rowDetail('Số Nhân', 'detail.soNhan.toString()'),
        rowDetail('Số Luồng', 'detail.soLuong.toString()'),
        rowDetail('Xung nhịp cơ bản', 'detail.xungNhipCoBan!'),
        rowDetail('Xung nhịp tối đa', 'detail.xungNhipToiDa!'),
        rowDetail('Thế Hệ', 'detail.theHe!'),
        rowDetail('Đồ Họa', 'detail.doHoa!', true),
      ],
    );
  }

  Widget rowDetail(String name, String detail, [bool isBottom = false]) {
    return ColoredBox(
      color: Colors.grey,
      child: Padding(
        padding: EdgeInsets.only(
          top: 1,
          left: 1,
          right: 1,
          bottom: isBottom ? 1 : 0,
        ),
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColoredBox(
                color: Colors.grey[200]!,
                child: SizedBox(
                  height: 40,
                  width: 200,
                  child: Center(child: CustomText(text: name)),
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: Colors.white,
                  child: SizedBox(
                    height: 40,
                    width: 200,
                    child: Center(child: CustomText(text: detail)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget verticalDivided() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ColoredBox(
        color: lightGrey,
        child: const SizedBox(
          height: 16,
          width: 1,
        ),
      ),
    );
  }
}
