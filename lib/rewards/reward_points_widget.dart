import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';
import 'package:jdonut_app_flutter/utils/format_utils.dart';

import 'donut_progress_indicator.dart';

class RewardPointsWidget extends StatelessWidget {
  const RewardPointsWidget({
    super.key,
    required this.point,
    required this.progress,
    required this.size,
    required this.width,
  });

  final int point;
  final double progress;
  final double size;
  final double width;

  @override
  Widget build(BuildContext context) {
    return DonutProgressIndicator(
      progress: progress,
      totalValue: 1,
      size: size,
      strokeWidth: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            child: Text(
              'Total points',
              style: TextStyle(
                color: Color(0xFFF6529A),
                fontFamily: AppTypo.menco,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
          ),
          SizedBox(height: 4),
          FittedBox(
            child: Text(
              FormatUtils.formatPrice(680000),
              style: TextStyle(
                color: Color(0xFFF6529A),
                fontSize: 24,
                fontFamily: AppTypo.menco,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
