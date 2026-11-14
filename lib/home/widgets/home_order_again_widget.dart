import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/home/widgets/home_section_header_widget.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

class HomeOrderAgainWidget extends StatelessWidget {
  const HomeOrderAgainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeSectionHeaderWidget(title: 'Order again'),
            const SizedBox(height: 16),
            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: const [
                  _VerticalProductCard(
                    title: "Santa’s favorite\ncookies set",
                    discountTag: '20% off',
                    placeholderColor: Color(0xFFFFF3E0),
                  ),
                  SizedBox(width: 16),
                  _VerticalProductCard(
                    title: "Santa’s favorite\ncookies set",
                    discountTag: '20% off',
                    placeholderColor: Color(0xFFE8EAF6),
                  ),
                  SizedBox(width: 16),
                  _VerticalProductCard(
                    title: "Holiday Special\nCocoa Pack",
                    discountTag: '15% off',
                    placeholderColor: Color(0xFFFBE9E7),
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

class _VerticalProductCard extends StatelessWidget {
  final String title;
  final String? discountTag;
  final Color placeholderColor;

  const _VerticalProductCard({
    required this.title,
    required this.discountTag,
    required this.placeholderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: placeholderColor,
                  borderRadius: BorderRadius.circular(16),
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
            padding: const EdgeInsets.all(12.0),
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