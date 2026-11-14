import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonut_app_flutter/auth/widgets/auth_top_bar_widget.dart';
import 'package:jdonut_app_flutter/routing/routes.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';
import 'package:jdonut_app_flutter/widgets/accept_aggrement_widget.dart';

class LoginNameScreen extends StatefulWidget {
  const LoginNameScreen({super.key});

  @override
  State<LoginNameScreen> createState() => _LoginNameScreenState();
}

class _LoginNameScreenState extends State<LoginNameScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFF7F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTopBarWidget(progress: 0.75),
              const SizedBox(height: 32),
              const Text(
                "What's your\nname?",
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: AppTypo.menco,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              const SizedBox(height: 32),

              TextField(
                controller: _firstNameController,
                keyboardType: TextInputType.name,
                style: TextStyle(fontSize: 14, fontFamily: AppTypo.generalSans),
                decoration: InputDecoration(
                  hintText: "First Name",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: AppTypo.generalSans,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _lastNameController,
                keyboardType: TextInputType.name,
                style: TextStyle(fontSize: 14, fontFamily: AppTypo.generalSans),
                decoration: InputDecoration(
                  hintText: "Last Name",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: AppTypo.generalSans,
                  ),
                  filled: true,
                  fillColor: Colors.white,
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
                    context.push(Routes.loginDate);
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
