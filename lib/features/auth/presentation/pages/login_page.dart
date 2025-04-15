import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/theme/app_colors.dart';
import 'package:flutter_dev_test/core/theme/text_styles.dart';
import 'package:flutter_dev_test/core/widgets/app_snack_bar.dart';
import 'package:flutter_dev_test/core/widgets/base_page.dart';
import 'package:flutter_dev_test/core/widgets/button.dart';
import 'package:flutter_dev_test/core/widgets/password_textfield.dart';
import 'package:flutter_dev_test/core/widgets/textfield_email.dart';
import 'package:flutter_dev_test/features/auth/bloc/login_bloc.dart';
import 'package:flutter_dev_test/features/auth/bloc/login_event.dart';
import 'package:flutter_dev_test/features/auth/bloc/login_state.dart';
import 'package:flutter_dev_test/features/auth/presentation/widgets/app_branding_widget.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Base(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.error.isNotEmpty) {
              showAppMessage(context, state.error);
            }
          },
          builder: (context, state) {
            final bloc = context.read<LoginBloc>();

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 72),
                const AppBranding(),
                const SizedBox(height: 38),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      EmailWidget(onChanged: (value) {
                        bloc.add(EmailChanged(value));
                      }),
                      const SizedBox(height: 10),
                      PasswordWidget(
                        onChanged: (value) {
                          bloc.add(PasswordChanged(value));
                        },
                        onSubmit: (_) => bloc.add(LoginSubmitted()),
                      ),
                      const SizedBox(height: 20),
                      ButtonWidget(
                        onPressed: () => bloc.add(LoginSubmitted()),
                        loading: state.loading,
                        title: 'Entrar',
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 209),
                Center(
                  child: InkWell(
                    onTap: () => showAppMessage(
                        context, 'Usuário: admin\nSenha: password123'),
                    child: Text(
                      'Esqueci a senha',
                      style: AppTextStyles.heading12.copyWith(
                        color: AppColors.brandBrown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 38),
              ],
            );
          },
        ),
      ),
    );
  }
}
