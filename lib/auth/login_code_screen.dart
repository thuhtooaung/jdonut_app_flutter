import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonut_app_flutter/auth/viewmodels/login_code_viewmodel.dart';
import 'package:jdonut_app_flutter/auth/widgets/auth_top_bar_widget.dart';
import 'package:jdonut_app_flutter/routing/routes.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';
import 'package:jdonut_app_flutter/utils/format_utils.dart';
import 'package:jdonut_app_flutter/widgets/accept_aggrement_widget.dart';
import 'package:pinput/pinput.dart';

class LoginCodeScreen extends ConsumerStatefulWidget {
  const LoginCodeScreen({super.key, required this.args});

  final OtpCodeArgs args;

  @override
  ConsumerState<LoginCodeScreen> createState() => _LoginCodeScreenState();
}

class _LoginCodeScreenState extends ConsumerState<LoginCodeScreen> {
  final _pinController = TextEditingController();

  final _defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: TextStyle(fontSize: 16, fontFamily: AppTypo.generalSans),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
  );

  void _onPressedVerify() {
    final pin = _pinController.text.trim();
    if (pin.isNotEmpty) {
      context.push(Routes.loginName);
    }
  }

  void _onResend() {
    ref.read(loginCodeViewModelProvider(widget.args).notifier).resendCode();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resendStatus = ref.watch(
      loginCodeViewModelProvider(
        widget.args,
      ).select((state) => state.resendStatus),
    );
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTopBarWidget(progress: 0.5),
              const SizedBox(height: 32),
              const Text(
                'Verify your number',
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: AppTypo.menco,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "We've sent 6 digit OTP to PHONE-NUMBER",
                style: TextStyle(fontSize: 12, fontFamily: AppTypo.generalSans),
              ),
              const SizedBox(height: 24),
              Pinput(
                length: 6,
                defaultPinTheme: _defaultPinTheme,
                controller: _pinController,
                showCursor: false,
                onCompleted: (value) {
                  _onPressedVerify();
                },
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Don't receive the code?",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: AppTypo.generalSans,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "resend in ",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: AppTypo.generalSans,
                              ),
                            ),
                            Text(
                              FormatUtils.formatDuration(
                                resendStatus.remainingSeconds,
                              ),
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 12,
                                fontFamily: AppTypo.generalSans,
                              ),
                            ),
                            const Text(
                              " min",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: AppTypo.generalSans,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (resendStatus.canResend)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _onResend,
                      child: Text(
                        "Resend",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              AcceptAgreementWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
