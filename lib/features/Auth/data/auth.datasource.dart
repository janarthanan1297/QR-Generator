import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:qrcode/core/utils/utils.dart';
import 'package:qrcode/services/permission.services.dart';

final authLogic = ChangeNotifierProvider((ref) => AuthLogic(ref.read));

class AuthLogic extends ChangeNotifier {
  final Reader ref;
  AuthLogic(this.ref);

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String verificationId = '';
  List<Placemark>? placemarks;
  GeoPoint? location;
  String? ipdata;

  void sendOTP(String phoneNumber) async {
    await firebaseAuth.verifyPhoneNumber(
      // ignore: prefer_interpolation_to_compose_strings
      phoneNumber: '+91 ' + phoneNumber,
      verificationCompleted: (verificationCompleted) {},
      verificationFailed: (verificationFailed) {},
      codeSent: (codeSent, token) {
        verificationId = codeSent;
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {},
    );
    notifyListeners();
  }

  create() async {
    User? user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.phoneNumber)
        .set({
      'userIp': ipdata,
      'location': location,
      'address': placemarks?[0].locality,
      'loginTime': DateTime.now().millisecondsSinceEpoch,
    }).whenComplete(() {});
  }

  void _getUserLocation() async {
    await ref(permissionService).requestLocationPermission();
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));
    placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    ipdata = await NetworkInfo().getWifiIP();
    location = GeoPoint(position.latitude, position.longitude);
    create();
    notifyListeners();
  }

  Future<void> verifyOTP(String otp) async {
    if (verificationId != '') {
      var cred = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final data = await firebaseAuth.signInWithCredential(cred);
      if (data.user?.uid != null) {
        _getUserLocation();
      }
    } else {
      return Utils().toast('Invalid OTP');
    }
  }
}
