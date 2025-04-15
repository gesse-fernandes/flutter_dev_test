import 'package:flutter/material.dart';
import 'package:flutter_dev_test/core/utils/validators.dart';
import 'package:flutter_dev_test/core/widgets/textfield.dart';

class PasswordWidget extends TextFieldWidget {
  const PasswordWidget({
    super.key,
    required super.onChanged,
    super.onSubmit,
    super.errorMessage,
    super.isEnabled,
    super.controller,
    super.initialValue,
    super.textInputAction,
  }) : super(
          hintText: 'Senha',
          keyboardType: TextInputType.text,
          isPassword: true,
          validator: Validators.password,
        );
}
