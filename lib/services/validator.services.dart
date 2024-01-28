import 'package:flutter_riverpod/flutter_riverpod.dart';

final validatorService =
    Provider<ValidatorService>((ref) => ValidatorServiceImpl(ref));

abstract class ValidatorService {
  String? phoneNumeberValidator(String? val);
  String? validateOTP(String? val);
}

class ValidatorServiceImpl extends ValidatorService {
  final Ref ref;

  ValidatorServiceImpl(this.ref);

  @override
  String? phoneNumeberValidator(String? val) {
    if (val!.isEmpty) {
      return "Mobile Number required";
    }

    if (val.length < 10) {
      return "10 digit required!";
    }

    if (val.contains(' ') || val.contains('.') || val.contains(',')) {
      return "Enter a valid mobile number";
    }
    return null;
  }

  @override
  String? validateOTP(String? val) {
    if (val!.isEmpty) {
      return 'OTP Required!';
    }
    if (val.length < 6) {
      return "6 digit required!";
    }
    return null;
  }
}
