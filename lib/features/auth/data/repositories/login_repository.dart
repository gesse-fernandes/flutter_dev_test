import 'package:flutter_dev_test/core/api/api_config.dart';
import 'package:flutter_dev_test/core/api/models/api_response.dart';
import 'package:flutter_dev_test/injection.dart';
import 'package:otp/otp.dart';

class LoginRepository {
  LoginRepository();

  Future<ApiResponse> login(
    String username,
    String password,
    String secret,
  ) async {
    final totpCode = generateTOTP(secret);
    final response = await api.post(
      ApiConfig.login,
      data: {
        'username': username,
        'password': password,
        'totp_code': totpCode,
      },
    );

    return response;
  }

  Future<String?> getCodeSecret() async {
    final secret = await storageService.get(ApiConfig.secret);

    if (secret == null) return null;
    return secret;
  }

  String generateTOTP(String secret) {
    return OTP.generateTOTPCodeString(
      secret,
      DateTime.now().millisecondsSinceEpoch,
      interval: 30,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );
  }
}
