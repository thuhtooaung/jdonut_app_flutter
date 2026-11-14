import 'package:go_router/go_router.dart';
import 'package:jdonut_app_flutter/auth/login_code_screen.dart';
import 'package:jdonut_app_flutter/auth/login_date_screen.dart';
import 'package:jdonut_app_flutter/auth/login_name_screen.dart';
import 'package:jdonut_app_flutter/auth/login_phone_screen.dart';
import 'package:jdonut_app_flutter/auth/starting_screen.dart';
import 'package:jdonut_app_flutter/auth/viewmodels/login_code_viewmodel.dart';
import 'package:jdonut_app_flutter/detail/product_detail_screen.dart';
import 'package:jdonut_app_flutter/main/main_screen.dart';
import 'package:jdonut_app_flutter/routing/routes.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.starting,
  routes: [
    GoRoute(
      path: Routes.starting,
      builder: (context, state) => StartingScreen(),
    ),
    GoRoute(
      path: Routes.loginPhone,
      builder: (context, state) => LoginPhoneScreen(),
    ),
    GoRoute(
      path: Routes.loginCode,
      builder: (context, state) {
        return LoginCodeScreen(args: state.extra as OtpCodeArgs);
      },
    ),
    GoRoute(
      path: Routes.loginName,
      builder: (context, state) => LoginNameScreen(),
    ),
    GoRoute(
      path: Routes.loginDate,
      builder: (context, state) => LoginDateScreen(),
    ),
    GoRoute(path: Routes.main, builder: (context, state) => MainScreen()),
    GoRoute(
      path: Routes.product,
      builder: (context, state) => ProductDetailScreen(),
    ),
  ],
);
