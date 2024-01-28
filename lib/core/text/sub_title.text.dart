import 'package:flutter/material.dart';
import 'package:qrcode/core/styles/colors.style.dart';

class AppSubTitleText extends StatelessWidget {
  final String? text;
  final Color? color;
  final bool isBold;
  final FontStyle? fontstyle;

  final int? maxLines;
  final TextAlign? align;
  const AppSubTitleText({
    Key? key,
    @required this.text,
    this.fontstyle,
    this.color = AppColors.black,
    this.maxLines,
    this.align,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text ?? '',
        maxLines: maxLines,
        textAlign: align,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontStyle: fontstyle,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal));
  }
}
