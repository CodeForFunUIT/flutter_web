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
                text: "Trạng thái chờ xử lý",
                weight: FontWeight.bold,
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(text: order.id),
              CustomText(text: order.date),
              CustomText(text: double.parse(order.price!).toVND()),
              CustomText(text: order.status),
            ],
          );
  }
}
