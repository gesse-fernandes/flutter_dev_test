class AppBaseState {
  final bool loading;
  final String error;
  final String message;

  AppBaseState({
    required this.loading,
    required this.error,
    required this.message,
  });

  AppBaseState copyWith({
    bool? loading,
    String? error,
    String? message,
  }) {
    return AppBaseState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }
}
