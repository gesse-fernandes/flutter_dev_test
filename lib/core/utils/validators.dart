class Validators {
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, insira um e-mail.';
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    if (!RegExp(pattern).hasMatch(value.trim())) {
      return 'E-mail inválido.';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Senha obrigatória.';
    }

    return null;
  }
}
