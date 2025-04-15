import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/theme/app_colors.dart';
import 'package:flutter_dev_test/core/theme/text_styles.dart';
import 'package:flutter_dev_test/core/widgets/app_snack_bar.dart';
import 'package:flutter_dev_test/core/widgets/base_page.dart';
import 'package:flutter_dev_test/core/widgets/button.dart';
import 'package:flutter_dev_test/core/widgets/textfield_otp.dart';
import 'package:flutter_dev_test/features/recovery/bloc/recovery_secret_bloc.dart';
import 'package:flutter_dev_test/features/recovery/bloc/recovery_secret_event.dart';
import 'package:flutter_dev_test/features/recovery/bloc/recovery_secret_state.dart';
import 'package:flutter_dev_test/features/recovery/presentation/widgets/resend_code_helper.dart';
import 'package:flutter_dev_test/injection.dart';

class Recovery extends StatefulWidget {
  const Recovery({super.key});

  @override
  State<Recovery> createState() => _RecoveryState();
}

class _RecoveryState extends State<Recovery> {
  final List<TextEditingController> _otpControllers = [];

  @override
  Widget build(BuildContext context) {
    return Base(
      child: BlocConsumer<RecoverySecretBloc, RecoverySecretState>(
        bloc: recoveryBloc,
        listener: (context, state) {
          if (state.error.isNotEmpty) {
            showAppMessage(context, state.error);
          }
          if (state.message.isNotEmpty) {
            showAppMessage(context, state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text('Verificação',
                    style: AppTextStyles.heading20
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                Text('Insira o código que foi enviado:',
                    style: AppTextStyles.heading14
                        .copyWith(color: AppColors.secondaryText)),
                const SizedBox(height: 72),
                OtpWidget(
                  onChanged: (code) => recoveryBloc.add(OtpCodeChanged(code)),
                  onControllersReady: (controllers) {
                    _otpControllers.clear();
                    _otpControllers.addAll(controllers);
                  },
                ),
                const SizedBox(height: 32),
                ButtonWidget(
                  onPressed: () => recoveryBloc.add(SubmitRecoveryCode()),
                  loading: state.loading,
                  title: 'Confirmar',
                ),
                const SizedBox(height: 40),
                ResendCodeHelper(
                  otpControllers: _otpControllers,
                  onCodeFilled: (code) =>
                      recoveryBloc.add(OtpCodeChanged(code)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
