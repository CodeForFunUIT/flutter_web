import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';

class UpDownButtonCart extends StatefulWidget {
  final void Function(int number) callBack;
  const UpDownButtonCart({
    super.key,
    required this.callBack,
  });

  @override
  State<UpDownButtonCart> createState() => _UpDownButtonCartState();
}

class _UpDownButtonCartState extends State<UpDownButtonCart> {
  late int number;
  late void Function(int number) _callBack;
  @override
  void initState() {
    cartController.number = 1;
    super.initState();
    number = 1;
    _callBack = widget.callBack;
  }

  void increase() {
    setState(() {
      number++;
      _callBack(number);
    });
  }

  void decrease() {
    if (number > 1) {
      setState(() {
        number--;
        _callBack(number);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: .5,
              color: Colors.grey,
            ),
          ),
          child: IconButton(
            onPressed: decrease,
            icon: const Icon(
              Icons.remove,
              size: 16,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
        ),
        const SizedBox(width: 2),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: .5,
              color: Colors.grey,
            ),
          ),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4.0),
              child: CustomText(
                text: number.toString(),
                weight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 2),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: .5,
              color: Colors.grey,
            ),
          ),
          child: IconButton(
            onPressed: increase,
            icon: const Icon(
              Icons.add,
            ),
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
        ),
      ],
    );
  }
}
