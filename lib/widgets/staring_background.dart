import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/theme/app_assets.dart';

class StartingBackground extends StatelessWidget {
  const StartingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Top-Left Asset
        Positioned(top: -80, left: 0, child: Image.asset(AppAssets.icSplash2)),

        // Bottom-Left Asset
        Positioned(
          bottom: 20,
          left: 0,
          child: Image.asset(AppAssets.icSplash1),
        ),

        // Top-Right Asset
        Positioned(top: -20, right: 0, child: Image.asset(AppAssets.icSplash3)),

        // Bottom-Right Asset
        Positioned(
          bottom: 40,
          right: 0,
          child: Image.asset(AppAssets.icSplash4),
        ),

        // Center Main Asset
        Positioned(
          bottom: 150,
          left: 0,
          right: 0,
          child: Center(child: Image(image: AssetImage(AppAssets.icSplash))),
        ),

        // Bottom Overflow Asset
        Positioned(
          bottom: -90,
          left: 0,
          right: 0,
          child: Center(child: Image.asset(AppAssets.icSplash5)),
        ),
      ],
    );
  }
}
