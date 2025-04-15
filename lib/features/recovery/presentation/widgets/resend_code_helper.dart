import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dev_test/core/theme/app_colors.dart';
import 'package:flutter_dev_test/core/theme/text_styles.dart';
import 'package:flutter_dev_test/core/utils/assets_path.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResendCodeHelper extends StatelessWidget {
  final List<TextEditingController> otpControllers;
  final void Function(String) onCodeFilled;

  const ResendCodeHelper({
    super.key,
    required this.otpControllers,
    required this.onCodeFilled,
  });

  void _showCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Código de recuperação"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Use o código padrão abaixo para continuar:",
              style: AppTextStyles.heading14
                  .copyWith(color: AppColors.secondaryText),
            ),
            const SizedBox(height: 16),
            SelectableText(
              "000010",
              style: AppTextStyles.heading20.copyWith(
                color: AppColors.backgroundDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(const ClipboardData(text: "000010"));
              for (int i = 0; i < 6; i++) {
                otpControllers[i].text = "000010"[i];
              }
              final code = otpControllers.map((c) => c.text).join();
              onCodeFilled(code);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Código preenchido automaticamente")),
              );
            },
            child: const Text("Copiar"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Fechar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => _showCodeDialog(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AssetPaths.iconQuestion),
            const SizedBox(width: 8),
            Text(
              'Não recebi o código',
              style: AppTextStyles.heading12.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
