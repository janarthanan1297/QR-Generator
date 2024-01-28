import 'package:flutter/material.dart';
import 'package:qrcode/core/styles/colors.style.dart';

class AppSubHeadingText extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? align;
  final bool isBold;
  final int? maxlines;

  const AppSubHeadingText({
    Key? key,
    @required this.text,
    this.color = AppColors.black,
    this.align,
    this.isBold = false,
    this.maxlines,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: align,
      maxLines: maxlines ?? 1,
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
          color: color, fontWeight: isBold ? FontWeight.bold : FontWeight.w400),
    );
  }
}
