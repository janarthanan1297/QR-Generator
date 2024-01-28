import 'package:flutter/material.dart';
import 'package:qrcode/core/styles/colors.style.dart';

class AppTitleText extends StatelessWidget {
  final String? text;
  final Color color;
  final bool isBold;
  final int? maxlines;
  final TextAlign? align;
  const AppTitleText({
    Key? key,
    @required this.text,
    this.align,
    this.color = AppColors.black,
    this.isBold = false,
    this.maxlines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      maxLines: maxlines ?? 1,
      textAlign: align,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
          // 16
          color: color,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
