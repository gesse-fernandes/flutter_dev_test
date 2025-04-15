import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dev_test/core/api/restClient.dart';
import 'package:http/http.dart' as http;

RestClientException parseRestClientError(http.Response response) {
  String? message;

  try {
    final json = jsonDecode(response.body);
    message = json['message'];
  } catch (_) {
    message = null;
  }

  if (kDebugMode) {
    print('[HTTP ERROR] ${response.statusCode}: $message');
  }

  switch (response.statusCode) {
    case 400:
      return BadRequestException(
          message: message ?? 'Erro nos dados enviados', res: response);
    case 401:
      if (message == 'Invalid credentials') {
        return UnauthorizedException(
            message: 'Credenciais inválidas', res: response);
      }
      if (message == 'Invalid TOTP code' ||
          message == 'Invalid recovery code') {
        return UnauthorizedException(message: 'Código inválido', res: response);
      }
      if (message == 'Invalid password') {
        return UnauthorizedException(
            message: 'Credenciais inválidas', res: response);
      }
      return UnauthorizedException(res: response);
    case 403:
      return ForbiddenException(res: response);
    case 404:
      return NotFoundException(res: response);
    case 409:
      return ConflictException(res: response);
    case 422:
      return UnprocessableEntityException(res: response);
    case 429:
      return TooManyRequestsException(res: response);
    case 408:
      return RequestTimeoutException(res: response);
    case 500:
    default:
      return ServerException(message: message ?? 'Erro interno', res: response);
  }
}
