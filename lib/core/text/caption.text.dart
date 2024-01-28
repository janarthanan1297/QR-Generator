import 'package:flutter/material.dart';
import 'package:qrcode/core/styles/colors.style.dart';

class AppCaptionText extends StatelessWidget {
  final String? text;
  final Color? color;
  final bool isBold;
  final TextAlign? align;
  final int maxLines;
  final double? height;
  const AppCaptionText(
      {Key? key,
      @required this.text,
      this.maxLines = 1,
      this.height,
      this.color = AppColors.black,
      this.isBold = false,
      this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      overflow: TextOverflow.ellipsis,
      textAlign: align,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          height: height),
    );
  }
}
