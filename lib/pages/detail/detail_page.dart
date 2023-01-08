import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/base/enum.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/controllers/product_controller.dart';
import 'package:flutter_web_electronic_components/models/cart.dart';
import 'package:flutter_web_electronic_components/models/product.dart';
import 'package:flutter_web_electronic_components/models/product_detail.dart';
import 'package:flutter_web_electronic_components/pages/auth/login.dart';
import 'package:flutter_web_electronic_components/pages/cart/cart_page.dart';
import 'package:flutter_web_electronic_components/widgets/app_bar.dart';
import 'package:flutter_web_electronic_components/widgets/custom_dialog.dart';
import 'package:flutter_web_electronic_components/widgets/custom_image.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/item_card.dart';
import 'package:flutter_web_electronic_components/widgets/loading.dart';
import 'package:flutter_web_electronic_components/widgets/up_down_button.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DetailPage extends StatelessWidget {
  Product? product;
  DetailPage({
    super.key,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImage(
                  image: product!.image!,
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: GetBuilder<ProductController>(
                    initState: (_) => productController.getDetailProduct(
                      product!.id!,
                    ),
                    builder: (controller) => controller.detail != null
                        ? Detail(
                            detail: controller.detail!,
                            product: product!,
                          )
                        : Shimmer.fromColors(
                            baseColor: baseShimmerColor,
                            highlightColor: highlightShimmerColor,
                            child: const SizedBox(height: 500, width: 200),
                          ),
                  ),
                ),

                // Expanded(flex: 6, child: Detail(product: product, detail: ,)),
              ],
            ),
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
  static const double sizeText = 16;

  Future<void> buy(BuildContext context) async {
    if (authController.user == null) {
      Get.dialog(const CustomDialog(type: DialogType.mustLogin));
    } else {
      Loading.startLoading(context);
      await cartController.addCart(
        cart: CartDetail(
          idProduct: product.id,
          number: '${cartController.number}',
          name: product.name,
          price: product.price,
          image: product.image,
        ),
      );
      Loading.stopLoading();

      Get.to(const CartPage());
    }
  }

  Future<void> addToCart(BuildContext context) async {
    Loading.startLoading(context);
    await cartController.getCart();
    int index = -1;
    for (var e in cartController.carts) {
      if (e?.idProduct == product.id) {
        index = cartController.carts.indexOf(e);
        break;
      }
    }
    if (index == -1) {
      print('not exist');
      await cartController.addCart(
        cart: CartDetail(
          idProduct: product.id,
          number: '${cartController.number}',
          name: product.name,
          price: product.price,
          image: product.image,
        ),
      );
    } else {
      cartController.carts[index]!.number =
          '${int.parse(cartController.carts[index]!.number!) + cartController.number}';
      print('exist');
      await cartController.setCarts(carts: cartController.carts);
    }

    Loading.stopLoading();
    Get.dialog(const CustomDialog(type: DialogType.addCartSuccess));
  }

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
          titleDetail(context),
          const Divider(),
          caseInfoDetail(),
          if (product.idProductType == '2') ...[
            const Divider(),
            checkRam(),
          ]
        ],
      ),
    );
  }

  Widget caseInfoDetail() {
    switch (int.parse(product.idProductType!)) {
      case 1:
        return inforCpuDetail();
      case 2:
        return inforRamDetail();
      case 6:
        return inforLaptopDetail();
      default:
        return const SizedBox.shrink();
    }
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

  Widget titleDetail(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: product.name,
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
                child: CustomText(text: product.id, color: blue),
              ),
              verticalDivided(),
              const Flexible(
                child: CustomText(
                  text: 'Thương hiệu: ',
                ),
              ),
              Flexible(
                child: CustomText(text: product.trademark, color: blue),
              ),
              verticalDivided(),
              const CustomText(
                text: 'Tình trạng: ',
              ),
              Flexible(
                child: CustomText(
                  text: int.parse(product.stock!) > 0 ? 'Còn hàng' : 'Hết hàng',
                  // text: 'Còn hàng',
                  color: int.parse(product.stock!) > 0 ? blue : Colors.red,
                  // color: blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: runSpacing),
          CustomText(
            text: double.parse(product.price!).toVND(),
            size: 24,
            color: Colors.red,
          ),
          const SizedBox(height: runSpacing),
          SizedBox(
            height: 40,
            // width: 150,
            child: UpDownButton(
              callBack: (number) {
                cartController.number = number;
              },
            ),
          ),
          const SizedBox(height: runSpacing),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    buy(context);
                  },
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
                  onPressed: () async => await addToCart(context),
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

  Widget youHaventLogin() {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomText(
              text: 'Bạn chưa đăng nhập',
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 24),
            const CustomText(
              text: 'Di chuyển đến màn hình đăng nhập',
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomText(
                      text: 'Hủy',
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => Get.to(const Login()),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomText(
                      text: 'Xác nhận',
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
        rowDetail('Tiến Trình', detail.tienTrinh),
        rowDetail('Số Nhân', detail.soNhan.toString()),
        rowDetail('Số Luồng', detail.soLuong.toString()),
        rowDetail('Xung nhịp cơ bản', detail.xungNhipCoBan),
        rowDetail('Xung nhịp tối đa', detail.xungNhipToiDa),
        rowDetail('Thế Hệ', detail.theHe),
        rowDetail('Đồ Họa', detail.doHoa, true),
      ],
    );
  }

  Widget inforLaptopDetail() {
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
        rowDetail('CPU', detail.cpu),
        rowDetail('RAM', detail.ramDetai),
        rowDetail('Ổ cứng', detail.oCung),
        rowDetail('Card đồ họa', detail.manHinh),
        rowDetail('Màn hình', detail.trongLuong),
        rowDetail('Hệ điều hành', 'Windows 10 pro'),
        rowDetail('Đọc thẻ nhớ', 'None'),
        rowDetail('Chuẩn Lan', 'None'),
        rowDetail('Chuẩn Wifi', '802.11ax (2x2)'),
        rowDetail('BlueTooth', 'v5.1'),
        rowDetail('Kích thước', '322 x 207 x 14.9 mm', true),
      ],
    );
  }

  Widget inforRamDetail() {
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
        rowDetail('Thương hiệu', product.trademark),
        rowDetail('Loại Ram', 'Laptop'),
        rowDetail('Dung Lượng', '${detail.ram} GB'),
        rowDetail('Chuẩn Ram', detail.chuanRam),
        rowDetail('BUS (Mhz)', detail.bus),
      ],
    );
  }

  Widget rowDetail(String name, String? detail, [bool isBottom = false]) {
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
