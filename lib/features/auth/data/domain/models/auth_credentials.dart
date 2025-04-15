class CredentialsModel {
  final String email;
  final String password;
  final String totpCode;

  CredentialsModel({
    required this.email,
    required this.password,
    required this.totpCode,
  });

  factory CredentialsModel.empty() {
    return CredentialsModel(
      email: '',
      password: '',
      totpCode: '',
    );
  }

  CredentialsModel copyWith({
    String? email,
    String? password,
    String? totpCode,
  }) {
    return CredentialsModel(
      email: email ?? this.email,
      password: password ?? this.password,
      totpCode: totpCode ?? this.totpCode,
    );
  }
}
