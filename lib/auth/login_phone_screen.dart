import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonut_app_flutter/auth/viewmodels/login_code_viewmodel.dart';
import 'package:jdonut_app_flutter/auth/widgets/auth_top_bar_widget.dart';
import 'package:jdonut_app_flutter/routing/routes.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';
import 'package:jdonut_app_flutter/widgets/accept_aggrement_widget.dart';

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  final _phoneController = TextEditingController();
  final _focusNode = FocusNode();
  bool _hasLostFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      setState(() {
        _hasLostFocus = true;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String _cleanPhone(String input) {
    var cleaned = input.replaceAll(RegExp(r'[\s\-]'), '');
    if (cleaned.startsWith('+95')) {
      cleaned = cleaned.substring(3);
    }
    if (cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1);
    }
    return cleaned;
  }

  bool _validatePhone(String input) {
    final cleaned = _cleanPhone(input);
    return RegExp(r'^9\d{7,9}$').hasMatch(cleaned);
  }

  @override
  Widget build(BuildContext context) {
    final rawPhone = _phoneController.text;
    final isValid = _validatePhone(rawPhone);
    final cleanedPhone = _cleanPhone(rawPhone);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTopBarWidget(progress: 0.25),
              const SizedBox(height: 32),
              const Text(
                'Enter your phone number',
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: AppTypo.menco,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              const SizedBox(height: 32),

              TextField(
                controller: _phoneController,
                focusNode: _focusNode,
                keyboardType: TextInputType.phone,
                onChanged: (_) => setState(() {}),
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: AppTypo.generalSans,
                  height: 1,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '+95',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontFamily: AppTypo.menco,
                        height: 1,
                      ),
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorText: (_hasLostFocus && !isValid)
                      ? 'Please enter a valid phone number (e.g. 09254135592)'
                      : null,
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: isValid
                      ? () {
                          context.push(
                            Routes.loginCode,
                            extra: OtpCodeArgs(
                              phone: '+95$cleanedPhone',
                              expireIn: 300,
                            ),
                          );
                        }
                      : null,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: isValid
                        ? const Color(0xFF4AC3E2)
                        : const Color(0xFF4AC3E2).withOpacity(0.4),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    "CONTINUE",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppTypo.menco,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              AcceptAgreementWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
