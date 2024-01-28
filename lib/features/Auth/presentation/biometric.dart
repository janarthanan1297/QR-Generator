import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrcode/core/styles/colors.style.dart';
import 'package:qrcode/core/utils/utils.dart';
import 'package:qrcode/core/text/heading.text.dart';
import 'package:qrcode/core/text/sub_title.text.dart';
import 'package:qrcode/features/Qr/presentation/index.dart';
import 'package:qrcode/services/biometric.service.dart';

class BiometricPage extends ConsumerStatefulWidget {
  const BiometricPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BiometricPageState();
}

class _BiometricPageState extends ConsumerState<BiometricPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final formkey = GlobalKey<FormState>();
  bool? isValid;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    Future.microtask(() async {
      bool isSupported = await ref.read(biometricService).checkDeviceSupport();
      if (isSupported) {
        isValid = await ref.read(biometricService).authenticate();
        if (isValid == true) {
          // ignore: use_build_context_synchronously
          Utils().routePopUntil(context, const Home());
        }
        setState(() {
          isValid = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.black,
        body: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    const AppHeadingText(
                      maxLines: 2,
                      align: TextAlign.center,
                      text: 'Hello!',
                      isBold: true,
                      color: AppColors.white,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppSubTitleText(
                        text: 'Use Touch ID to login to your account',
                        color: AppColors.white.withOpacity(.4)),
                    const SizedBox(
                      height: 120,
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/fingerprint.svg',
                        height: 140,
                        width: 140,
                      ),
                    ),
                    const SizedBox(height: 70),
                    InkWell(
                      onTap: () {
                        init();
                      },
                      child: const Center(
                        child: AppSubTitleText(
                          text: 'Try again',
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
