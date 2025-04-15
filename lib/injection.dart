import 'package:flutter_dev_test/core/api/api.dart';
import 'package:flutter_dev_test/core/local%20Storage/local_storage.dart';
import 'package:flutter_dev_test/features/auth/bloc/login_bloc.dart';
import 'package:flutter_dev_test/features/home/bloc/home_bloc.dart';
import 'package:flutter_dev_test/features/recovery/bloc/recovery_secret_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  // Core
  getIt.registerSingleton(HttpClientService());
  getIt.registerSingleton(LocalStorageService());
  //bloc
  getIt.registerSingleton(HomeBloc());
  getIt.registerSingleton(LoginBloc());
  getIt.registerSingleton(RecoverySecretBloc());
}

// Acesso fácil
HttpClientService get api => getIt<HttpClientService>();
LocalStorageService get storageService => getIt<LocalStorageService>();

HomeBloc get homeBloc => getIt<HomeBloc>();
LoginBloc get loginBloc => getIt<LoginBloc>();
RecoverySecretBloc get recoveryBloc => getIt<RecoverySecretBloc>();
