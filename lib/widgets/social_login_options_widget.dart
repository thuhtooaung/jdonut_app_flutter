import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/theme/app_assets.dart';

class SocialLoginOptionsWidget extends StatelessWidget {
  const SocialLoginOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 32,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: Image.asset(AppAssets.icGoogle, width: 32, height: 32),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: Image.asset(AppAssets.icFacebook, width: 32, height: 32),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: Image.asset(AppAssets.icApple, width: 32, height: 32),
        ),
      ],
    );
  }
}
