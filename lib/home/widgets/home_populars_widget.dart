import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

import 'home_section_header_widget.dart';

class HomePopularsWidget extends StatelessWidget {
  const HomePopularsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeSectionHeaderWidget(title: 'Popular 🔥'),
            const SizedBox(height: 16),
            SizedBox(
              height: 320,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: const [
                  _VerticalProductCard(
                    title: 'Strawberry\nChocolate Donuts',
                    placeholderColor: Color(0xFFFCE4EC),
                  ),
                  SizedBox(width: 16),
                  _VerticalProductCard(
                    title: 'Dalgona Creamy\nCoffee',
                    placeholderColor: Color(0xFFEFEBE9),
                  ),
                  SizedBox(width: 16),
                  _VerticalProductCard(
                    title: 'Matcha Green\nTea Latte',
                    placeholderColor: Color(0xFFE8F5E9),
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
  final Color placeholderColor;

  const _VerticalProductCard({
    required this.title,
    required this.placeholderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              color: placeholderColor,
              borderRadius: BorderRadius.circular(16),
            ),
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
