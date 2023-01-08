import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_web_electronic_components/base/enum.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/controllers/navigator_controller.dart';
import 'package:flutter_web_electronic_components/pages/home/all_product.dart';
import 'package:flutter_web_electronic_components/widgets/custom_dialog.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:get/get.dart';

class IconDropDown extends StatefulWidget {
  final IconData icon;
  final List<Item> items;
  final double size;
  final Widget? button;
  const IconDropDown({
    Key? key,
    required this.icon,
    required this.items,
    this.size = 46,
    this.button,
  }) : super(key: key);

  @override
  State<IconDropDown> createState() => _IconDropDownState();
}

class _IconDropDownState extends State<IconDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: widget.button ??
            Icon(
              widget.icon,
              size: widget.size,
              shadows: const [],
            ),
        customItemsHeights: [
          ...List<double>.filled(widget.items.length, 48),
          // 8,
          // ...List<double>.filled(MenuItems.secondItems.length, 48),
        ],
        items: [
          ...widget.items.map(
            (item) => DropdownMenuItem<Item>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
          // const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
          // ...MenuItems.secondItems.map(
          //   (item) => DropdownMenuItem<MenuItem>(
          //     value: item,
          //     child: MenuItems.buildItem(item),
          //   ),
          // ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value as Item);
        },
        itemHeight: 48,
        itemPadding: const EdgeInsets.only(left: 16, right: 16),
        dropdownWidth: 160,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        dropdownElevation: 8,
        offset: const Offset(0, 8),
      ),
    );
  }
}

class Item {
  final String text;
  final IconData icon;

  const Item({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<Item> menuItems = [cpu, laptop, ram];
  static const List<Item> account = [logout, order];

  static const cpu = Item(text: 'Cpu', icon: Icons.memory);
  static const laptop = Item(text: 'Laptop', icon: Icons.laptop);
  static const ram = Item(text: 'Rams', icon: Icons.settings);
  static const logout = Item(text: 'Đăng xuất', icon: Icons.logout);
  static const order = Item(text: 'Đơn hàng', icon: Icons.shopping_cart);

  static Widget buildItem(Item item) {
    return Row(
      children: [
        Icon(
          item.icon,
          color: Colors.black,
          size: 22,
        ),
        const SizedBox(
          width: 10,
        ),
        CustomText(
          text: item.text,
          color: Colors.black,
        ),
      ],
    );
  }

  static onChanged(BuildContext context, Item item) {
    switch (item) {
      case MenuItems.cpu:
        Get.offAll(const AllProductScreen(title: 'CPU', idProductType: '1'));
        break;
      case MenuItems.ram:
        Get.offAll(const AllProductScreen(title: 'RAM', idProductType: '2'));
        break;
      case MenuItems.laptop:
        Get.offAll(const AllProductScreen(title: 'Laptop', idProductType: '6'));
        break;
      case MenuItems.logout:
        authController.logout();
        Get.dialog(const CustomDialog(type: DialogType.logout));
        break;
      case MenuItems.order:
        Get.toNamed(orderPage);
        break;
    }
  }
}
