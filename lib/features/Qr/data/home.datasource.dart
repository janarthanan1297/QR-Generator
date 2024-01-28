import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode/core/utils/datetime.extension.dart';
import 'package:qrcode/core/utils/utils.dart';

final homeLogic = ChangeNotifierProvider((ref) => HomeLogic(ref.read));

class HomeLogic extends ChangeNotifier {
  final Reader ref;
  HomeLogic(this.ref);

  String? formattime;
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMm1234567890NnOoPpQqRrSsTtUuVvWwXxYyZz';
  final Random _rnd = Random();
  List<Map<String, dynamic>> qrdata = [];
  DocumentSnapshot<Map<String, dynamic>>? snapdata;

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future fetchuserdata() async {
    User? user = FirebaseAuth.instance.currentUser;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.phoneNumber)
        .get();

    if (!snapshot.exists) return;

    final time =
        DateTime.fromMillisecondsSinceEpoch(snapshot.data()!['loginTime']);
    final day = time.formatddMMMyyyy();
    if (time.isToday()) {
      formattime = 'Today, ${time.formatHHmm()}';
    } else if (time.isYesterDay()) {
      formattime = 'Yesterday, ${time.formatHHmm()}';
    } else {
      formattime = '$day, ${time.formatHHmm()}';
    }
    notifyListeners();
  }

  update(String data, BuildContext context) async {
    Utils().showLoader(context);
    User? user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.phoneNumber)
        .collection('qrcode')
        .add({
      'time': DateTime.now().millisecondsSinceEpoch,
      'code': data,
    }).whenComplete(() {
      Utils().dismissLoader(context);
      Utils().toast('Data Saved');
    });
  }

  Future fetchLastdata() async {
    qrdata = [];
    User? user = FirebaseAuth.instance.currentUser;
    snapdata = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.phoneNumber)
        .get();

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.phoneNumber)
        .collection('qrcode')
        .get();
    for (var val in snapshot.docs) {
      qrdata.add(val.data());
    }

    notifyListeners();
  }
}
