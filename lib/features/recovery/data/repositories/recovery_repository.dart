import 'package:flutter_dev_test/core/api/api_config.dart';
import 'package:flutter_dev_test/injection.dart';

class RecoveryRepository {
  Future<bool> submitCode(
    String username,
    String password,
    String code,
  ) async {
    final response = await api.post(
      ApiConfig.recovery,
      data: {
        'username': username,
        'password': password,
        'code': code,
      },
    );

    final secret = response.data["totp_secret"];

    if (secret != null) {
      storageService.set(ApiConfig.secret, data: secret);
      return true;
    }

    return false;
  }
}
