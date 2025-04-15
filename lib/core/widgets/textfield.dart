import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dev_test/core/theme/app_colors.dart';
import 'package:flutter_dev_test/core/theme/text_styles.dart';

class TextFieldWidget extends StatelessWidget {
  final String? errorMessage;
  final String? hintText;
  final bool isPassword;
  final bool isEnabled;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final String? initialValue;
  final TextEditingController? controller;
  final int? maxLines;
  final Function(String)? onSubmit;

  const TextFieldWidget({
    super.key,
    this.errorMessage,
    this.hintText,
    this.isPassword = false,
    this.isEnabled = true,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.initialValue,
    this.controller,
    this.maxLines = 1,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            obscureText: isPassword,
            controller: controller,
            enabled: isEnabled,
            validator: validator,
            maxLines: maxLines,
            initialValue: initialValue,
            onChanged: onChanged,
            onFieldSubmitted: onSubmit,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            textInputAction: textInputAction,
            style: AppTextStyles.heading12.copyWith(
              color: AppColors.foreground,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: AppTextStyles.heading12.copyWith(
                color: AppColors.foreground,
              ),
            ),
          ),
        ),
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              errorMessage!,
              style: AppTextStyles.heading12.copyWith(color: AppColors.error),
            ),
          ),
      ],
    );
  }
}
