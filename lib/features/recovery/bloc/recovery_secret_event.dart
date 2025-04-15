import 'package:flutter_dev_test/features/auth/data/domain/models/auth_credentials.dart';

abstract class RecoverySecretEvent {}

class OtpCodeChanged extends RecoverySecretEvent {
  final String code;
  OtpCodeChanged(this.code);
}

class ModelUpdated extends RecoverySecretEvent {
  final CredentialsModel model;
  ModelUpdated(this.model);
}

class SubmitRecoveryCode extends RecoverySecretEvent {}
