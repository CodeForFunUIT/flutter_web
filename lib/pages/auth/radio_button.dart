import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';

class RadioButton extends StatefulWidget {
  final void Function(String sex) callBack;

  const RadioButton({
    super.key,
    required this.callBack,
  });

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  String? _character = 'male';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Row(
            children: [
              Radio<String>(
                value: 'male',
                groupValue: _character,
                onChanged: (String? value) {
                  setState(() {
                    _character = value;
                    widget.callBack(value!);
                  });
                },
              ),
              const SizedBox(width: 16),
              const CustomText(text: 'male'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Radio<String>(
                value: 'female',
                groupValue: _character,
                onChanged: (String? value) {
                  setState(() {
                    _character = value;
                    widget.callBack(value!);
                  });
                },
              ),
              const SizedBox(width: 8),
              const CustomText(text: 'female'),
            ],
          ),
        ),
        const Spacer(
          flex: 2,
        )
      ],
    );
  }
}
