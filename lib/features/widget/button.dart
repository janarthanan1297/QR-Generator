import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode/core/styles/border_radius.style.dart';
import 'package:qrcode/core/styles/colors.style.dart';
import 'package:qrcode/core/styles/dimen.style.dart';
import 'package:qrcode/core/text/sub_heading.text.dart';

class PrimaryButton extends ConsumerWidget {
  final String? title;
  final Function onTap;
  const PrimaryButton({super.key, required this.onTap, this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: Dimen.scaffoldInnerPadding,
        decoration: BoxDecoration(
          color: AppColors.darkgrey,
          borderRadius: radius14,
        ),
        child: AppSubHeadingText(
          text: title,
          color: AppColors.white,
        ),
      ),
    );
  }
}
