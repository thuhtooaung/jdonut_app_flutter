import 'dart:math';

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

class _LoginCodeScreenState extends ConsumerState<LoginCodeScreen>
    with SingleTickerProviderStateMixin {
  final _pinController = TextEditingController();
  late AnimationController _shakeController;

  int _failedAttempts = 0;
  bool _isLocked = false;
  String? _errorMessage;

  final _defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: TextStyle(fontSize: 16, fontFamily: AppTypo.generalSans),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
  );

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  void _onPressedVerify() {
    if (_isLocked) return;

    final pin = _pinController.text.trim();
    if (pin.length != 6) return;

    if (pin == '123456') {
      setState(() {
        _errorMessage = null;
      });
      context.push(Routes.loginName);
    } else {
      _failedAttempts++;
      _shakeController.forward(from: 0.0);
      _pinController.clear();

      setState(() {
        if (_failedAttempts >= 3) {
          _isLocked = true;
          _errorMessage =
              '3 wrong codes. Entry is locked until you tap Resend.';
        } else {
          _errorMessage = 'Invalid verification code. Please try again.';
        }
      });
    }
  }

  void _onResend() {
    setState(() {
      _failedAttempts = 0;
      _isLocked = false;
      _errorMessage = null;
      _pinController.clear();
    });
    ref.read(loginCodeViewModelProvider(widget.args).notifier).resendCode();
  }

  @override
  void dispose() {
    _shakeController.dispose();
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
              Text(
                "We've sent 6 digit OTP to ${widget.args.phone}",
                style: const TextStyle(fontSize: 12, fontFamily: AppTypo.generalSans),
              ),
              const SizedBox(height: 24),
              AnimatedBuilder(
                animation: _shakeController,
                builder: (context, child) {
                  final double offset =
                      sin(_shakeController.value * pi * 4) * 10;
                  return Transform.translate(
                    offset: Offset(offset, 0),
                    child: child,
                  );
                },
                child: Pinput(
                  length: 6,
                  enabled: !_isLocked,
                  defaultPinTheme: _defaultPinTheme,
                  controller: _pinController,
                  showCursor: false,
                  onCompleted: (value) {
                    _onPressedVerify();
                  },
                ),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 8),
                Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontFamily: AppTypo.generalSans,
                  ),
                ),
              ],
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
                  if (resendStatus.canResend || _isLocked)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _onResend,
                      child: Text(
                        "Resend",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF5288),
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
