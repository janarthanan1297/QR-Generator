import 'package:flutter/material.dart';
import 'package:qrcode/core/styles/border_radius.style.dart';
import 'package:qrcode/core/styles/colors.style.dart';
import 'package:qrcode/core/text/heading.text.dart';

class UiWidget extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final String? title;
  final Widget child;
  final double height, top, left;
  const UiWidget(
      {super.key,
      required this.child,
      this.formKey,
      this.title,
      this.height = 110,
      this.top = 95,
      this.left = 130});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Container(
              height: height,
              color: AppColors.purple,
            ),
            child,
            Positioned(
              top: top,
              left: left,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration:
                    BoxDecoration(borderRadius: radius6, color: AppColors.blue),
                child: AppHeadingText(
                  text: title,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
