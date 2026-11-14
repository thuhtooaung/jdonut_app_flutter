import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/theme/app_assets.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

class HomeNearbyShopsWidget extends StatelessWidget {
  const HomeNearbyShopsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Image.asset(
            AppAssets.bgSectionShops,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              spacing: 24,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 32),
                  child: Text(
                    "There are 4 J'Donut shops near you.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: AppTypo.menco,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF33CEF7),
                    ),
                    child: Text(
                      "EXPLORE NOW",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: AppTypo.generalSans,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 280,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    children: const [
                      _StoreLocationCard(
                        title: "Myaynigone J'Donut",
                        address: "2972 Pyay Road, Sanchaung\nTownship, Yangon.",
                        actionText: "Order Online",
                        placeholderColor: Color(0xFFE0F7FA),
                      ),
                      SizedBox(width: 16),
                      _StoreLocationCard(
                        title: "Downtown J'Donut",
                        address:
                            "45 Sule Pagoda Road, Kyauktada\nTownship, Yangon.",
                        actionText: "Order Online",
                        placeholderColor: Color(0xFFE1F5FE),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StoreLocationCard extends StatelessWidget {
  final String title;
  final String address;
  final String actionText;
  final Color placeholderColor;

  const _StoreLocationCard({
    required this.title,
    required this.address,
    required this.actionText,
    required this.placeholderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: placeholderColor,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontFamily: AppTypo.generalSans,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontFamily: AppTypo.generalSans,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            actionText,
            style: TextStyle(
              color: Colors.pink,
              fontSize: 14,
              fontFamily: AppTypo.generalSans,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
