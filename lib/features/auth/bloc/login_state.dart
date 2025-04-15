import 'package:flutter_dev_test/features/app_base_state.dart';
import 'package:flutter_dev_test/features/auth/data/domain/models/auth_credentials.dart';

class LoginState extends AppBaseState {
  final CredentialsModel model;

  LoginState({
    required super.loading,
    required super.error,
    required super.message,
    required this.model,
  });

  factory LoginState.initial() {
    return LoginState(
      loading: false,
      error: '',
      message: '',
      model: CredentialsModel.empty(),
    );
  }

  @override
  LoginState copyWith({
    bool? loading,
    String? error,
    String? message,
    CredentialsModel? model,
  }) {
    return LoginState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      message: message ?? this.message,
      model: model ?? this.model,
    );
  }
}
