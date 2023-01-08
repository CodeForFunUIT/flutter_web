import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/models/order.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/item_card.dart';

class OrderInfor extends StatelessWidget {
  final bool isTitle;
  final Order order;
  const OrderInfor({
    super.key,
    this.isTitle = false,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return isTitle
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CustomText(
                text: "Mã đơn hàng",
                weight: FontWeight.bold,
              ),
              CustomText(
                text: "Ngày đặt",
                weight: FontWeight.bold,
              ),
              CustomText(
                text: "Thành tiền",
                weight: FontWeight.bold,
              ),
              CustomText(
                text: "Trạng thái Đơn hàng",
                weight: FontWeight.bold,
              ),
            ],
          )
        : Row(
            children: [
              const SizedBox(width: 76),
              CustomText(text: order.id),
              const SizedBox(width: 88),
              CustomText(text: order.date),
              const SizedBox(width: 40),
              CustomText(text: double.parse(order.price!).toVND()),
              const SizedBox(width: 50),
              Flexible(
                child: CustomText(
                  text: status(order.status!),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
  }

  String status(String status) {
    switch (status) {
      case 'outDate':
        return 'Đơn hàng quá hạn';
      case 'pending':
        return 'Đơn hàng đang xử lý';
      case 'approve':
        return 'Đơn hàng được chấp nhận';
      case 'decline':
        return 'Đơn hàng bị từ chối';

      default:
        return '';
    }
  }
}
