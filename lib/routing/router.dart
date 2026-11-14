import 'package:go_router/go_router.dart';
import 'package:jdonut_app_flutter/auth/login_code_screen.dart';
import 'package:jdonut_app_flutter/auth/login_date_screen.dart';
import 'package:jdonut_app_flutter/auth/login_name_screen.dart';
import 'package:jdonut_app_flutter/auth/login_phone_screen.dart';
import 'package:jdonut_app_flutter/auth/starting_screen.dart';
import 'package:jdonut_app_flutter/auth/viewmodels/login_code_viewmodel.dart';
import 'package:jdonut_app_flutter/detail/product_detail_screen.dart';
import 'package:jdonut_app_flutter/home/presentation/models/product_args.dart';
import 'package:jdonut_app_flutter/main/main_screen.dart';
import 'package:jdonut_app_flutter/routing/routes.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.starting,
  routes: [
    GoRoute(
      path: Routes.starting,
      builder: (context, state) => const StartingScreen(),
    ),
    GoRoute(
      path: Routes.loginPhone,
      builder: (context, state) => const LoginPhoneScreen(),
    ),
    GoRoute(
      path: Routes.loginCode,
      builder: (context, state) {
        return LoginCodeScreen(args: state.extra as OtpCodeArgs);
      },
    ),
    GoRoute(
      path: Routes.loginName,
      builder: (context, state) => const LoginNameScreen(),
    ),
    GoRoute(
      path: Routes.loginDate,
      builder: (context, state) => const LoginDateScreen(),
    ),
    GoRoute(path: Routes.main, builder: (context, state) => const MainScreen()),
    GoRoute(
      path: Routes.product,
      builder: (context, state) => ProductDetailScreen(
        args: state.extra is ProductArgs ? state.extra as ProductArgs : null,
      ),
    ),
  ],
);
