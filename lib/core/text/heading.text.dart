import 'package:flutter/material.dart';
import 'package:qrcode/core/styles/colors.style.dart';

class AppHeadingText extends StatelessWidget {
  final String? text;
  final Color? color;
  final bool isBold;
  final TextAlign? align;
  final int maxLines;
  final double? fontSize;

  const AppHeadingText({
    Key? key,
    @required this.text,
    this.color = AppColors.black,
    this.isBold = false,
    this.maxLines = 2,
    this.fontSize,
    this.align,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      maxLines: maxLines,
      textAlign: align,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w400),
    );
  }
}
