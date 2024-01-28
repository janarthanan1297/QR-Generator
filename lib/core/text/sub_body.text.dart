import 'package:flutter/material.dart';
import 'package:qrcode/core/styles/colors.style.dart';

class AppSubBodyText extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? align;
  final bool isBold;
  final int? maxlines;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;

  const AppSubBodyText({
    Key? key,
    required this.text,
    this.color = AppColors.black,
    this.align,
    this.isBold = false,
    this.maxlines,
    this.overflow,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: align,
      maxLines: maxlines ?? 1,
      overflow: overflow,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color,
            fontWeight:
                isBold ? FontWeight.bold : fontWeight ?? FontWeight.normal,
          ),
    );
  }
}
