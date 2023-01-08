import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final int? maxLines;
  final FontStyle? style;
  final FontWeight? weight;
  final TextAlign? textAlign;

  const CustomText({
    Key? key,
    required this.text,
    this.size,
    this.color,
    this.weight,
    this.maxLines,
    this.style,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size ?? 16,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,
        fontStyle: style,
      ),
      maxLines: maxLines,
    );
  }
}
