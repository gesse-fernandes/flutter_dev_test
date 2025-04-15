import 'package:dartz/dartz.dart';
import 'package:flutter_dev_test/core/api/restClient.dart';

abstract class ServiceExecutor {
  Future<Either<String, T>> run<T>(Future<T> Function() task) async {
    try {
      final result = await task();
      return right(result);
    } on RestClientException catch (e) {
      return left(e.message);
    } catch (e) {
      return left('Erro inesperado: ${e.toString()}');
    }
  }
}
