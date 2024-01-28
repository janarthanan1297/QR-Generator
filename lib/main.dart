import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrcode/core/theme/theme.dart';
import 'package:qrcode/features/Auth/presentation/biometric.dart';
import 'package:qrcode/features/Auth/presentation/index.dart';
import 'package:qrcode/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
        title: 'QR Generator',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: (user == null) ? const Login() : const BiometricPage());
  }
}
