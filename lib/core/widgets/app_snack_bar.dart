import 'package:flutter/material.dart';
import 'package:flutter_dev_test/core/theme/app_colors.dart';
import 'package:flutter_dev_test/core/theme/text_styles.dart';

void showAppMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(message: message));
}

class AppSnackBar extends SnackBar {
  final String message;
  AppSnackBar({
    required this.message,
    super.key,
  }) : super(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Text(
                  message,
                  style: AppTextStyles.heading12.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.backgroundDark,
          elevation: 6,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          width: 347,
        );
}
