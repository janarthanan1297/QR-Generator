import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode/core/styles/border_radius.style.dart';
import 'package:qrcode/core/styles/colors.style.dart';
import 'package:qrcode/core/utils/datetime.extension.dart';
import 'package:qrcode/core/text/sub_title.text.dart';

class QrCard extends ConsumerWidget {
  final DateTime time;
  final Map<String, dynamic>? qrdata;
  final DocumentSnapshot<Map<String, dynamic>>? snapdata;
  final bool others;
  const QrCard(
      {super.key,
      required this.time,
      this.qrdata,
      this.snapdata,
      this.others = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                others == false
                    ? AppSubTitleText(
                        text: time.formatHHmm(),
                        color: AppColors.white,
                      )
                    : AppSubTitleText(
                        text: '${time.formatddMMMyyyy()}, ${time.formatHHmm()}',
                        color: AppColors.white,
                      ),
                const SizedBox(
                  height: 5,
                ),
                AppSubTitleText(
                  text: qrdata?['code'],
                  color: AppColors.white,
                ),
                const SizedBox(
                  height: 5,
                ),
                AppSubTitleText(
                  text: snapdata?.data()?['userIp'],
                  color: AppColors.white,
                ),
                const SizedBox(
                  height: 5,
                ),
                AppSubTitleText(
                  text: snapdata?.data()?['address'],
                  color: AppColors.white,
                ),
              ],
            ),
            const Spacer(),
            Container(
              decoration:
                  BoxDecoration(borderRadius: radius14, color: AppColors.white),
              padding: const EdgeInsets.all(10),
              width: 100,
              child: QrImageView(
                data: qrdata?['code'],
                version: QrVersions.auto,
                size: 100.0,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
