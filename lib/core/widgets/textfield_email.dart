import 'package:flutter/material.dart';
import 'package:flutter_dev_test/core/utils/validators.dart';
import 'package:flutter_dev_test/core/widgets/textfield.dart';

class EmailWidget extends TextFieldWidget {
  const EmailWidget({
    super.key,
    required super.onChanged,
    super.errorMessage,
    super.isEnabled,
    super.controller,
    super.initialValue,
    super.textInputAction,
  }) : super(
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: Validators.email,
        );
}
