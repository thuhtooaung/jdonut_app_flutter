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
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();

  bool _firstNameTouched = false;
  bool _lastNameTouched = false;

  @override
  void initState() {
    super.initState();
    _firstNameFocusNode.addListener(() {
      if (!_firstNameFocusNode.hasFocus) {
        setState(() {
          _firstNameTouched = true;
        });
      }
    });
    _lastNameFocusNode.addListener(() {
      if (!_lastNameFocusNode.hasFocus) {
        setState(() {
          _lastNameTouched = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  String? _validateFirstName(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return 'First name is required';
    }
    if (trimmed.length > 50) {
      return 'First name must be 50 characters or less';
    }
    if (RegExp(r'[\d\u1040-\u1049]').hasMatch(trimmed)) {
      return 'First name cannot contain digits';
    }
    if (!RegExp(r'^[\p{L}\p{M}\s]+$', unicode: true).hasMatch(trimmed)) {
      return 'First name can only contain letters and spaces';
    }
    return null;
  }

  String? _validateLastName(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return null; // Optional
    }
    if (trimmed.length > 50) {
      return 'Last name must be 50 characters or less';
    }
    if (RegExp(r'[\d\u1040-\u1049]').hasMatch(trimmed)) {
      return 'Last name cannot contain digits';
    }
    if (!RegExp(r'^[\p{L}\p{M}\s]+$', unicode: true).hasMatch(trimmed)) {
      return 'Last name can only contain letters and spaces';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final firstNameError = _firstNameTouched
        ? _validateFirstName(_firstNameController.text)
        : null;
    final lastNameError = _lastNameTouched
        ? _validateLastName(_lastNameController.text)
        : null;

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
                focusNode: _firstNameFocusNode,
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
                  errorText: firstNameError,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _lastNameController,
                focusNode: _lastNameFocusNode,
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
                  errorText: lastNameError,
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _firstNameTouched = true;
                      _lastNameTouched = true;
                    });

                    final firstErr =
                        _validateFirstName(_firstNameController.text);
                    final lastErr =
                        _validateLastName(_lastNameController.text);

                    if (firstErr == null && lastErr == null) {
                      context.push(Routes.loginDate);
                    }
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
