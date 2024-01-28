import 'package:local_auth/local_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final biometricService = Provider<BiometricService>(
  (ref) => BiometricServiceImpl(),
);

abstract class BiometricService {
  Future<bool> checkDeviceSupport();
  Future<bool> authenticate();
}

class BiometricServiceImpl implements BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  @override
  Future<bool> checkDeviceSupport() async => await _auth.isDeviceSupported();

  @override
  Future<bool> authenticate() async {
    try {
      const options = AuthenticationOptions(stickyAuth: true);
      final data = await _auth.authenticate(
        options: options,
        localizedReason: 'Scan to Authenticate',
      );
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
