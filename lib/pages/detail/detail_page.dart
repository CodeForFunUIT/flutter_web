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
          text: 'Ki???m tra laptop c?? b??? thi???u RAM hay kh??ng?',
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
            text: 'B?????c 1: Nh???p chu???t ph???i v??o thanh ',
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
                text: '-> ch???n ',
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
            text: 'B?????c 2: Ch???n ???',
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
                text: '??? trong ',
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
          text: 'B?????c 3: Ki???m tra xem m???c ???Memory??? ???? ?????y hay ch??a.',
          style: FontStyle.italic,
        ),
        const SizedBox(height: 24),
        const CustomText(
          text:
              'N???u ???Memory??? hi???n tr??n 80% trong th???i gian d??i v?? kh??ng m??? t??c v??? n???ng, th?? laptop c???a b???n ??ang trong t??nh tr???ng thi???u RAM h??? th???ng.',
          maxLines: null,
        ),
        const SizedBox(height: 24),
        const CustomText(
          text:
              'M???t ??i???u ?????c bi???t l??u ?? l?? m???c ???Slots used??? c??ng c???n xem x??t c???n tr???ng trong vi???c n??ng c???p RAM. N???u hi???n m???c ???1 of 2??? th?? m??y ch??? m???i s??? d???ng 1 khe RAM, c?? th??? g???n th??m 1 khe n???a, co??n ???1 of 1??? co?? nghi??a la?? ma??y chi?? co?? 1 khe RAM.',
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
                  text: 'M?? s???n ph???m: ',
                ),
              ),
              Flexible(
                child: CustomText(text: product.id, color: blue),
              ),
              verticalDivided(),
              const Flexible(
                child: CustomText(
                  text: 'Th????ng hi???u: ',
                ),
              ),
              Flexible(
                child: CustomText(text: product.trademark, color: blue),
              ),
              verticalDivided(),
              const CustomText(
                text: 'T??nh tr???ng: ',
              ),
              Flexible(
                child: CustomText(
                  text: int.parse(product.stock!) > 0 ? 'C??n h??ng' : 'H???t h??ng',
                  // text: 'C??n h??ng',
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
                          text: 'Nh???n t???i c???a h??ng',
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
                    text: 'Th??m v??o gi??? h??ng',
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
              text: 'B???n ch??a ????ng nh???p',
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 24),
            const CustomText(
              text: 'Di chuy???n ?????n m??n h??nh ????ng nh???p',
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
                      text: 'H???y',
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
                      text: 'X??c nh???n',
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
          text: 'Th??ng s??? k??? thu???t',
          weight: FontWeight.bold,
          size: 24,
        ),
        const SizedBox(height: 24),
        rowDetail('Ti???n Tr??nh', detail.tienTrinh),
        rowDetail('S??? Nh??n', detail.soNhan.toString()),
        rowDetail('S??? Lu???ng', detail.soLuong.toString()),
        rowDetail('Xung nh???p c?? b???n', detail.xungNhipCoBan),
        rowDetail('Xung nh???p t???i ??a', detail.xungNhipToiDa),
        rowDetail('Th??? H???', detail.theHe),
        rowDetail('????? H???a', detail.doHoa, true),
      ],
    );
  }

  Widget inforLaptopDetail() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Th??ng s??? k??? thu???t',
          weight: FontWeight.bold,
          size: 24,
        ),
        const SizedBox(height: 24),
        rowDetail('CPU', detail.cpu),
        rowDetail('RAM', detail.ramDetai),
        rowDetail('??? c???ng', detail.oCung),
        rowDetail('Card ????? h???a', detail.manHinh),
        rowDetail('M??n h??nh', detail.trongLuong),
        rowDetail('H??? ??i???u h??nh', 'Windows 10 pro'),
        rowDetail('?????c th??? nh???', 'None'),
        rowDetail('Chu???n Lan', 'None'),
        rowDetail('Chu???n Wifi', '802.11ax (2x2)'),
        rowDetail('BlueTooth', 'v5.1'),
        rowDetail('K??ch th?????c', '322 x 207 x 14.9 mm', true),
      ],
    );
  }

  Widget inforRamDetail() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Th??ng s??? k??? thu???t',
          weight: FontWeight.bold,
          size: 24,
        ),
        const SizedBox(height: 24),
        rowDetail('Th????ng hi???u', product.trademark),
        rowDetail('Lo???i Ram', 'Laptop'),
        rowDetail('Dung L?????ng', '${detail.ram} GB'),
        rowDetail('Chu???n Ram', detail.chuanRam),
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
