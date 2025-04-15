import 'package:dartz/dartz.dart';
import 'package:flutter_dev_test/core/api/ServiceExecutor.dart';
import 'package:flutter_dev_test/core/api/models/api_response.dart';
import 'package:flutter_dev_test/features/auth/data/repositories/login_repository.dart';

class LoginService extends ServiceExecutor {
  final loginRepository = LoginRepository();

  LoginService();

  Future<Either<String, ApiResponse>> login(
    String username,
    String password,
    String secret,
  ) {
    return run(() => loginRepository.login(username, password, secret));
  }

  Future<Either<String, String?>> getCodeSecret() {
    return run(loginRepository.getCodeSecret);
  }
}
