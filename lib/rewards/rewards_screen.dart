import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/rewards/earn_by_drink_widget.dart';
import 'package:jdonut_app_flutter/rewards/earn_by_eat_widget.dart';
import 'package:jdonut_app_flutter/rewards/member_status_widget.dart';
import 'package:jdonut_app_flutter/rewards/reward_points_widget.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey.shade300,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 24, top: 60, bottom: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "J' Donuts Rewards",
                      style: TextStyle(
                        fontSize: 26,
                        fontFamily: AppTypo.menco,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      spacing: 4,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Rewards",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: AppTypo.generalSans,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Badge.count(
                          count: 2,
                          textColor: Colors.black,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 280,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: MemberStatusWidget()),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            bottom: 50,
                            child: RewardPointsWidget(
                              point: 68000,
                              progress: 0.75,
                              size: 200,
                              width: 46,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 24,
                      color: Colors.white,
                    ),
                    Container(
                      width: double.infinity,
                      height: 24,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF4CD4F7),
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: AppTypo.generalSans,
                          fontWeight: FontWeight.w500,
                        ),
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                      onPressed: () {},
                      child: Text("Eat more earn more"),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black,
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: AppTypo.generalSans,
                          fontWeight: FontWeight.w500,
                        ),
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                      onPressed: () {},
                      child: Text("Gift"),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                children: [
                  EarnByEatWidget(total: 4, value: 4),
                  EarnByEatWidget(total: 4, value: 1),
                  EarnByDrinkWidget(total: 4, value: 1),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
