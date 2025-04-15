import 'package:flutter_dev_test/core/routes/router_names.dart';
import 'package:flutter_dev_test/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_dev_test/features/home/presentation/pages/home_page.dart';
import 'package:flutter_dev_test/features/recovery/presentation/pages/recovery_page.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RouterNames.login,
  routes: [
    GoRoute(
      path: RouterNames.login,
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: RouterNames.recovery,
      builder: (context, state) => const Recovery(),
    ),
    GoRoute(
      path: RouterNames.home,
      builder: (context, state) => const Home(),
    ),
  ],
);
