import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/routes/router.dart';
import 'package:flutter_dev_test/core/routes/router_names.dart';
import 'package:flutter_dev_test/features/home/bloc/home_event.dart';
import 'package:flutter_dev_test/features/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<IndexChanged>((event, emit) async {
      if (event.index == 1) {
        router.go(RouterNames.login);
      }
      emit(state.copyWith(index: event.index));
    });
  }
}
