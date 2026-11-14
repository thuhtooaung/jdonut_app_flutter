import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonut_app_flutter/theme/app_assets.dart';

class AuthTopBarWidget extends StatelessWidget {
  const AuthTopBarWidget({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(12),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: context.pop,
        ),
        SizedBox(
          width: 24,
          height: 24,
          child: progress < 1
              ? CircularProgressIndicator(
                  value: progress,
                  backgroundColor: const Color(0xFF4AC3E2),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFFFF5288),
                  ),
                  strokeWidth: 8,
                )
              : Image.asset(AppAssets.icComplete),
        ),
      ],
    );
  }
}
