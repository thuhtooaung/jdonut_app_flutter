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

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                keyboardType: TextInputType.phone,
                style: TextStyle(
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
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    context.push(
                      Routes.loginCode,
                      extra: OtpCodeArgs(
                        phone: _phoneController.text,
                        expireIn: 300,
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: const Color(0xFF4AC3E2),
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
