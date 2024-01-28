import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode/core/utils/datetime.extension.dart';

import 'package:qrcode/features/widget/qr_card.dart';

class OthersList extends ConsumerWidget {
  final DocumentSnapshot<Map<String, dynamic>>? snapdata;
  final List<Map<String, dynamic>>? qrdata;
  const OthersList({super.key, this.snapdata, this.qrdata});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
        itemCount: qrdata?.length,
        itemBuilder: (context, i) {
          final time = DateTime.fromMillisecondsSinceEpoch(qrdata?[i]['time']);
          return !time.isToday() && !time.isYesterDay()
              ? QrCard(
                  time: time,
                  qrdata: qrdata?[i],
                  snapdata: snapdata,
                  others: true,
                )
              : const SizedBox.shrink();
        });
  }
}
