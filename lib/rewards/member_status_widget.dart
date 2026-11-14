import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/theme/app_assets.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

class MemberStatusWidget extends StatelessWidget {
  const MemberStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        SizedBox(
          width: 48,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Image.asset(AppAssets.icSilver, height: 48),
              ),
              Positioned(
                top: 48,
                left: 23,
                child: SizedBox(
                  height: 52,
                  width: 2,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: LinearProgressIndicator(
                      value: 0.5,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.black45,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                child: Image.asset(AppAssets.icGold, height: 48),
              ),
              Positioned(
                top: 148,
                left: 24,
                child: SizedBox(
                  height: 52,
                  width: 2,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: LinearProgressIndicator(
                      value: 0,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                child: Image.asset(AppAssets.icPlatinum, height: 48),
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _MemberStatusTextWidget(
                  label: "Silver",
                  value: "You're here now",
                ),
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: _MemberStatusTextWidget(
                  label: "Gold",
                  value: "500 pts Remaining to become Gold",
                ),
              ),
              Positioned(
                top: 200,
                left: 0,
                right: 0,
                child: _MemberStatusTextWidget(
                  label: "Platinum",
                  value: "You'll be here soon",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MemberStatusTextWidget extends StatelessWidget {
  const _MemberStatusTextWidget({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontFamily: AppTypo.menco,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 12, fontFamily: AppTypo.generalSans),
        ),
      ],
    );
  }
}
