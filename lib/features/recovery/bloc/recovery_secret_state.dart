import 'package:flutter_dev_test/features/app_base_state.dart';
import 'package:flutter_dev_test/features/auth/data/domain/models/auth_credentials.dart';

class RecoverySecretState extends AppBaseState {
  final CredentialsModel model;

  RecoverySecretState({
    required super.loading,
    required super.error,
    required super.message,
    required this.model,
  });

  @override
  RecoverySecretState copyWith({
    bool? loading,
    String? error,
    String? message,
    CredentialsModel? model,
  }) {
    return RecoverySecretState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      message: message ?? this.message,
      model: model ?? this.model,
    );
  }

  factory RecoverySecretState.initial() {
    return RecoverySecretState(
      loading: false,
      error: '',
      message: '',
      model: CredentialsModel.empty(),
    );
  }
}
