import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/routes/router.dart';
import 'package:flutter_dev_test/core/routes/router_names.dart';
import 'package:flutter_dev_test/features/recovery/bloc/recovery_secret_event.dart';
import 'package:flutter_dev_test/features/recovery/bloc/recovery_secret_state.dart';
import 'package:flutter_dev_test/features/recovery/data/domain/services/recovery_services.dart';

class RecoverySecretBloc
    extends Bloc<RecoverySecretEvent, RecoverySecretState> {
  RecoverySecretBloc() : super(RecoverySecretState.initial()) {
    on<OtpCodeChanged>((event, emit) {
      emit(state.copyWith(
        model: state.model.copyWith(totpCode: event.code),
        error: '',
      ));
    });

    on<ModelUpdated>((event, emit) {
      emit(state.copyWith(model: event.model));
    });

    on<SubmitRecoveryCode>((event, emit) async {
      emit(state.copyWith(loading: true));

      final result = await RecoveryService().submitCode(
        state.model.email,
        state.model.password,
        state.model.totpCode,
      );

      result.fold(
        (l) => emit(state.copyWith(loading: false, error: l)),
        (r) {
          if (r) {
            emit(state.copyWith(
              loading: false,
              message: 'Código recuperado com sucesso',
            ));
            router.go(RouterNames.login);
          } else {
            emit(state.copyWith(loading: false, error: 'Código inválido'));
          }
        },
      );

      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(error: '', message: ''));
    });
  }
}
