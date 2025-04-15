import 'package:dartz/dartz.dart';
import 'package:flutter_dev_test/core/api/ServiceExecutor.dart';
import 'package:flutter_dev_test/features/recovery/data/repositories/recovery_repository.dart';

class RecoveryService extends ServiceExecutor {
  final recoveryRepository = RecoveryRepository();

  Future<Either<String, bool>> submitCode(
    String username,
    String password,
    String code,
  ) {
    return run(
      () => recoveryRepository.submitCode(
        username,
        password,
        code,
      ),
    );
  }
}
