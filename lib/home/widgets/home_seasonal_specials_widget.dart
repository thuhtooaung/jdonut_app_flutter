import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/home/widgets/home_section_header_widget.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

class HomeSeasonalSpecialsWidget extends StatelessWidget {
  const HomeSeasonalSpecialsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeSectionHeaderWidget(title: 'Seasonal specials'),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: const [
                  _SeasonalProductCard(
                    title: 'Mistletoe\nRomance box',
                    discountTag: '50% off',
                    placeholderColor: Color(0xFFE2D8D0),
                  ),
                  SizedBox(width: 16),
                  _SeasonalProductCard(
                    title: 'Christmas Mix\nFamily box',
                    placeholderColor: Color(0xFFD3DCE2),
                  ),
                  SizedBox(width: 16),
                  _SeasonalProductCard(
                    title: 'Winter Glaze\nSpecial pack',
                    discountTag: '20% off',
                    placeholderColor: Color(0xFFE5DFD3),
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

class _SeasonalProductCard extends StatelessWidget {
  final String title;
  final String? discountTag;
  final Color placeholderColor;

  const _SeasonalProductCard({
    required this.title,
    this.discountTag,
    required this.placeholderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 160,
                width: 240,
                decoration: BoxDecoration(
                  color: placeholderColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              if (discountTag != null)
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF37B2B),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      discountTag!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: AppTypo.generalSans,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontFamily: AppTypo.generalSans,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
