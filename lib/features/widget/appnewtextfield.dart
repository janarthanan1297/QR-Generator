import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrcode/core/styles/border_radius.style.dart';
import 'package:qrcode/core/styles/colors.style.dart';
import 'package:qrcode/core/styles/dimen.style.dart';

class AppTextFeildNew extends StatelessWidget {
  final Color fillColor;
  final String? title;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final String? hint;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obsecureText;
  final bool? autoValidate;
  final bool isRequired;
  final int maxlines;
  final int minlines;
  final bool isMobileNumber;
  final Widget? suffixIcon;
  final Function(String)? onChanged, onSubmit;
  final InputBorder? border;

  const AppTextFeildNew({
    Key? key,
    this.fillColor = AppColors.darkgrey,
    this.title,
    this.border,
    this.validator,
    this.controller,
    this.enabled = true,
    this.hint,
    this.keyboardType,
    this.inputFormatters,
    this.obsecureText = false,
    this.autoValidate,
    this.onChanged,
    this.onSubmit,
    this.isRequired = false,
    this.maxlines = 1,
    this.minlines = 1,
    this.isMobileNumber = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius14,
      ),
      child: TextFormField(
        style: const TextStyle(fontSize: 16, color: AppColors.white),
        enabled: enabled,
        maxLines: maxlines,
        minLines: minlines,
        validator: validator,
        controller: controller,
        obscureText: obsecureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        onFieldSubmitted: onSubmit,
        onEditingComplete: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: fillColor,
          focusColor: fillColor,
          contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
          helperText: hint,
          errorStyle: const TextStyle(fontSize: 12),
          labelStyle: TextStyle(
              color: const Color(0xffC5CEE0), fontSize: Dimen.subHeading),
          hintStyle: TextStyle(
              color: const Color(0xffC5CEE0), fontSize: Dimen.subHeading),
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.white,
        ),
      ),
    );
  }
}
