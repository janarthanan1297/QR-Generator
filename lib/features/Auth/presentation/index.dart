import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode/core/styles/colors.style.dart';
import 'package:qrcode/core/styles/dimen.style.dart';
import 'package:qrcode/core/utils/utils.dart';
import 'package:qrcode/core/text/sub_heading.text.dart';
import 'package:qrcode/features/Auth/data/auth.datasource.dart';
import 'package:qrcode/features/widget/appnewtextfield.dart';
import 'package:qrcode/features/widget/button.dart';
import 'package:qrcode/features/widget/uiwidget.dart';
import 'package:qrcode/features/Qr/presentation/index.dart';
import 'package:qrcode/services/permission.services.dart';
import 'package:qrcode/services/validator.services.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends ConsumerState<Login> {
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController otp = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isOtpSent = false;

  @override
  void initState() {
    Future.microtask(() async =>
        await ref.read(permissionService).requestLocationPermission());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final validator = ref.read(validatorService);
    final notifier = ref.read(authLogic.notifier);

    return UiWidget(
      formKey: formKey,
      title: 'LOGIN',
      child: Container(
        padding: Dimen.scaffoldInnerPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            const AppSubHeadingText(
              text: 'Phone number',
              color: AppColors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            AppTextFeildNew(
              controller: phonenumber,
              fillColor: const Color(0xff2d2c5c),
              keyboardType: TextInputType.number,
              validator: validator.phoneNumeberValidator,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
            ),
            Visibility(
              visible: isOtpSent == true,
              child: const SizedBox(
                height: 25,
              ),
            ),
            Visibility(
              visible: isOtpSent == true,
              child: const AppSubHeadingText(
                text: 'OTP',
                color: AppColors.white,
              ),
            ),
            Visibility(
              visible: isOtpSent == true,
              child: const SizedBox(
                height: 10,
              ),
            ),
            Visibility(
              visible: isOtpSent == true,
              child: AppTextFeildNew(
                controller: otp,
                fillColor: const Color(0xff2d2c5c),
                keyboardType: TextInputType.number,
                validator: validator.validateOTP,
                inputFormatters: [LengthLimitingTextInputFormatter(6)],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            PrimaryButton(
              title: isOtpSent == true ? 'LOGIN' : 'SEND OTP',
              onTap: () async {
                if (formKey.currentState!.validate() && isOtpSent == true) {
                  Utils().showLoader(context);
                  await notifier.verifyOTP(otp.text);
                  Timer(const Duration(seconds: 1), () {
                    User? user = FirebaseAuth.instance.currentUser;
                    Utils().dismissLoader(context);
                    if (user != null) {
                      Utils().routeReplace(context, const Home());
                    }
                  });
                }
                if (isOtpSent == false) {
                  notifier.sendOTP(phonenumber.text);
                  Utils().toast('OTP Sent please wait');
                  setState(() {
                    isOtpSent = true;
                  });
                }
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
