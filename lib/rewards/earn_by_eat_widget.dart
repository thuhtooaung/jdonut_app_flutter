import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/rewards/eat_progress_widget.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

class EarnByEatWidget extends StatelessWidget {
  const EarnByEatWidget({super.key, required this.total, required this.value});

  final int total;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 420),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EatProgressWidget(progress: value / total),
          const SizedBox(width: 20),
          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Eat 4 Coco donuts',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: AppTypo.generalSans,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$value/$total',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: AppTypo.generalSans,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF4CD4F7),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade300,
                        disabledForegroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 13,
                          fontFamily: AppTypo.generalSans,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: total == value ? () {} : null,
                      child: Text("EARN"),
                    ),
                    const SizedBox(width: 14),
                    // Points text
                    const Text(
                      '100 pts',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: AppTypo.generalSans,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
