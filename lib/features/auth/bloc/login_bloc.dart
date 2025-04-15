import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/routes/router.dart';
import 'package:flutter_dev_test/core/routes/router_names.dart';
import 'package:flutter_dev_test/features/auth/bloc/login_event.dart';
import 'package:flutter_dev_test/features/auth/bloc/login_state.dart';
import 'package:flutter_dev_test/features/auth/data/domain/services/Login_service.dart';
import 'package:flutter_dev_test/features/recovery/bloc/recovery_secret_bloc.dart';
import 'package:flutter_dev_test/features/recovery/bloc/recovery_secret_event.dart';
import 'package:flutter_dev_test/injection.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(
        model: state.model.copyWith(email: event.email),
        error: '',
      ));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        model: state.model.copyWith(password: event.password),
        error: '',
      ));
    });

    on<LoginSubmitted>((event, emit) async {
      if (state.model.email.isEmpty || state.model.password.isEmpty) {
        emit(state.copyWith(error: 'Preencha e-mail e senha.'));
        return;
      }

      emit(state.copyWith(loading: true));

      final totpCode = await LoginService().getCodeSecret();
      final success = await totpCode.fold(
        (l) async {
          emit(state.copyWith(loading: false, error: l));
          return false;
        },
        (r) async {
          if (r == null) {
            emit(state.copyWith(loading: false));
            getIt<RecoverySecretBloc>().add(ModelUpdated(state.model));

            router.push(RouterNames.recovery);
            return false;
          }

          emit(state.copyWith(
            model: state.model.copyWith(totpCode: r),
          ));

          final result = await LoginService().login(
            state.model.email,
            state.model.password,
            r,
          );

          return result.fold(
            (l) {
              emit(state.copyWith(loading: false, error: l));
              return false;
            },
            (_) {
              emit(LoginState.initial());
              router.go(RouterNames.home);
              return true;
            },
          );
        },
      );

      if (success) {
        emit(LoginState.initial());
      }

      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(message: '', error: ''));
    });
  }
}
