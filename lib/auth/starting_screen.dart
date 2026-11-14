import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonut_app_flutter/routing/routes.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';
import 'package:jdonut_app_flutter/widgets/accept_aggrement_widget.dart';
import 'package:jdonut_app_flutter/widgets/social_login_options_widget.dart';
import 'package:jdonut_app_flutter/widgets/staring_background.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: size.height * 0.52,
              child: StartingBackground(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentGeometry.topCenter,
                        end: AlignmentGeometry.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.01),
                          Colors.white.withValues(alpha: 0.75),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16,
                    ),
                    child: Column(
                      spacing: 24,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Round food for\nevery mood',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 38,
                            fontFamily: AppTypo.menco,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        const SizedBox(),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              context.push(Routes.loginPhone);
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                              backgroundColor: const Color(0xFF4AC3E2),
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              "LET'S GET STARTED",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: AppTypo.menco,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        // Already have an account? Log In
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: const Color(0xFF8E8E93),
                                fontSize: 16,
                                fontFamily: AppTypo.menco,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                  color: const Color(0xFFFF5288),
                                  fontSize: 16,
                                  fontFamily: AppTypo.menco,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SocialLoginOptionsWidget(),
                        AcceptAgreementWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
