import 'package:flutter/material.dart';
import 'package:qrcode/core/styles/colors.style.dart';
import 'package:qrcode/core/styles/dimen.style.dart';

class AppTheme {
  // Private Constructor
  AppTheme._();

  static final textTheme = TextTheme(
    // ignore: deprecated_member_use
    headline1: TextStyle(
      fontSize: Dimen.heading,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      letterSpacing: 0,
    ),
    // ignore: deprecated_member_use
    headline2: TextStyle(
      fontSize: Dimen.subHeading,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      letterSpacing: 0,
    ),
    // ignore: deprecated_member_use
    headline3: TextStyle(
      fontSize: Dimen.title,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      letterSpacing: 0,
    ),
    // ignore: deprecated_member_use
    subtitle1: TextStyle(
      fontSize: Dimen.subtitle,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
      letterSpacing: 0,
    ),
    // ignore: deprecated_member_use
    bodyText1: TextStyle(
      fontSize: Dimen.body,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
      letterSpacing: 0,
    ),
    // ignore: deprecated_member_use
    bodyText2: TextStyle(
      fontSize: Dimen.subBody,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
      letterSpacing: 0,
    ),
    // ignore: deprecated_member_use
    caption: TextStyle(
      fontSize: Dimen.caption,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
      letterSpacing: 0,
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: AppColors.white),
      color: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.white),
      foregroundColor: AppColors.black,
      elevation: 0,
    ),
    textTheme: textTheme,
    // textSelectionTheme:
    //     const TextSelectionThemeData(cursorColor: AppColors.primary),
  );
}
