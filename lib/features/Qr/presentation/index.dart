import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode/core/styles/border_radius.style.dart';
import 'package:qrcode/core/styles/colors.style.dart';
import 'package:qrcode/core/styles/dimen.style.dart';
import 'package:qrcode/core/utils/utils.dart';
import 'package:qrcode/core/text/sub_heading.text.dart';
import 'package:qrcode/core/text/sub_title.text.dart';
import 'package:qrcode/core/text/title.text.dart';
import 'package:qrcode/features/Auth/presentation/index.dart';
import 'package:qrcode/features/Qr/data/home.datasource.dart';
import 'package:qrcode/features/Qr/presentation/previous_data.dart';
import 'package:qrcode/features/widget/button.dart';
import 'package:qrcode/features/widget/uiwidget.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState<Home> {
  String data = '';
  String? ip;
  String? ipdata;
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    ref.read(homeLogic.notifier).fetchuserdata();
    setState(() {
      data = ref.read(homeLogic.notifier).getRandomString(6);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formattime = ref.watch(homeLogic).formattime ?? '';

    return Scaffold(
        backgroundColor: AppColors.purple,
        appBar: AppBar(
          backgroundColor: AppColors.purple,
          actions: [
            InkWell(
              onTap: () async {
                Utils().showLoader(context);
                await FirebaseAuth.instance.signOut();
                Timer(const Duration(seconds: 1), () {
                  Utils().dismissLoader(context);
                  Utils().toast('Logged out Successfully');
                  Utils().routeReplace(context, const Login());
                });
              },
              child: const Center(
                child: AppTitleText(
                  text: 'Logout',
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: UiWidget(
          title: 'PLUGIN',
          height: 15,
          top: 0,
          child: Container(
            padding: Dimen.scaffoldInnerPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: radius14, color: AppColors.white),
                  padding: const EdgeInsets.all(15),
                  child: QrImageView(
                    data: data,
                    version: QrVersions.auto,
                    size: 200.0,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(10.0),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const AppTitleText(
                  text: 'Generated Code',
                  color: AppColors.white,
                ),
                AppSubTitleText(
                  text: data,
                  color: AppColors.white,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Utils().router(context, const PreviousData());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: Dimen.scaffoldInnerPadding,
                    decoration: BoxDecoration(
                        borderRadius: radius14,
                        border: Border.all(color: AppColors.darkgrey)),
                    child: AppSubHeadingText(
                      text: formattime == ''
                          ? 'Last login'
                          : 'Last login at $formattime',
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  title: 'SAVE',
                  onTap: () async {
                    ref.read(homeLogic.notifier).update(data, context);
                  },
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ));
  }
}
