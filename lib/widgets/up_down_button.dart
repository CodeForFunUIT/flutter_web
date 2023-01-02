import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';

class UpDownButton extends StatefulWidget {
  final void Function(int number) callBack;
  const UpDownButton({
    super.key,
    required this.callBack,
  });

  @override
  State<UpDownButton> createState() => _UpDownButtonState();
}

class _UpDownButtonState extends State<UpDownButton> {
  late int number;
  late void Function(int number) _callBack;
  @override
  void initState() {
    super.initState();
    cartController.number = 1;
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
    return ColoredBox(
      color: Colors.grey[200]!,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: decrease,
            icon: const Icon(
              Icons.remove,
              size: 16,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: ColoredBox(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: CustomText(
                    text: number.toString(),
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: increase,
            icon: const Icon(
              Icons.add,
              size: 16,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
        ],
      ),
    );
  }
}
