import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode/core/styles/colors.style.dart';
import 'package:qrcode/core/utils/utils.dart';
import 'package:qrcode/core/text/title.text.dart';
import 'package:qrcode/features/Auth/presentation/index.dart';
import 'package:qrcode/features/Qr/data/home.datasource.dart';
import 'package:qrcode/features/Qr/presentation/others_list.dart';
import 'package:qrcode/features/Qr/presentation/today_list.dart';
import 'package:qrcode/features/Qr/presentation/yesterday_list.dart';
import 'package:qrcode/features/widget/uiwidget.dart';

class PreviousData extends ConsumerStatefulWidget {
  const PreviousData({super.key});

  @override
  PreviousDataState createState() => PreviousDataState();
}

class PreviousDataState extends ConsumerState<PreviousData>
    with TickerProviderStateMixin {
  String data = '';
  String? ip;
  String? ipdata;
  GlobalKey globalKey = GlobalKey();
  String? formattime;

  late TabController tab;

  @override
  void initState() {
    tab = TabController(length: 3, vsync: this);
    ref.read(homeLogic.notifier).fetchLastdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final qrdata = ref.watch(homeLogic).qrdata;
    final snapdata = ref.watch(homeLogic).snapdata;
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
                  Utils().routePopUntil(context, const Login());
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
          title: 'LAST LOGIN',
          height: 15,
          top: 0,
          left: 120,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              TabBar(
                controller: tab,
                indicatorColor: AppColors.white,
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.darkgrey,
                tabs: const [
                  Tab(text: 'Today'),
                  Tab(text: 'Yesterday'),
                  Tab(text: 'others'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  controller: tab,
                  children: [
                    TodayList(
                      snapdata: snapdata,
                      qrdata: qrdata,
                    ),
                    YesterdayList(
                      snapdata: snapdata,
                      qrdata: qrdata,
                    ),
                    OthersList(
                      snapdata: snapdata,
                      qrdata: qrdata,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
