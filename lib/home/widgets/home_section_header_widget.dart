import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

class HomeSectionHeaderWidget extends StatelessWidget {
  final String title;

  const HomeSectionHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontFamily: AppTypo.menco,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF1E1E1E),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
