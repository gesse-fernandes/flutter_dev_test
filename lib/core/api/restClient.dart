import 'package:http/http.dart' as http;

class RestClientException implements Exception {
  final int? statusCode;
  final String message;
  final http.Response? response;

  const RestClientException({
    this.statusCode,
    required this.message,
    this.response,
  });

  @override
  String toString() =>
      'RestClientException($statusCode): $message\n${response?.body ?? ''}';
}

class UnauthorizedException extends RestClientException {
  UnauthorizedException({
    super.message = 'Não autorizado',
    http.Response? res,
  }) : super(statusCode: 401, response: res);
}

class NotFoundException extends RestClientException {
  NotFoundException({
    super.message = 'Recurso não encontrado',
    http.Response? res,
  }) : super(statusCode: 404, response: res);
}

class BadRequestException extends RestClientException {
  BadRequestException({
    super.message = 'Erro nos dados enviados',
    http.Response? res,
  }) : super(statusCode: 400, response: res);
}

class ForbiddenException extends RestClientException {
  ForbiddenException({
    super.message = 'Acesso negado',
    http.Response? res,
  }) : super(statusCode: 403, response: res);
}

class ServerException extends RestClientException {
  ServerException({
    super.message = 'Erro interno no servidor',
    http.Response? res,
  }) : super(statusCode: 500, response: res);
}

class ConflictException extends RestClientException {
  ConflictException({
    super.message = 'Conflito encontrado nos dados enviados',
    http.Response? res,
  }) : super(statusCode: 409, response: res);
}

class UnprocessableEntityException extends RestClientException {
  UnprocessableEntityException({
    super.message = 'Erro ao processar a entidade enviada',
    http.Response? res,
  }) : super(statusCode: 422, response: res);
}

class TooManyRequestsException extends RestClientException {
  TooManyRequestsException({
    super.message = 'Muitas requisições',
    http.Response? res,
  }) : super(statusCode: 429, response: res);
}

class RequestTimeoutException extends RestClientException {
  RequestTimeoutException({
    super.message = 'Requisição expirou',
    http.Response? res,
  }) : super(statusCode: 408, response: res);
}

class NotLoggedUser implements Exception {
  @override
  String toString() => 'Usuário não autenticado';
}
