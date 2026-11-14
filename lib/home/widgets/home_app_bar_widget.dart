import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 360,
      pinned: false,
      floating: false,
      snap: false,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFFFDEEE2),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            border: Border(bottom: BorderSide(color: Colors.white, width: 2)),
          ),
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  spacing: 14,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD8C2B0),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Column(
                      spacing: 6,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hania',
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: AppTypo.menco,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        Text(
                          'Bronze member',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontFamily: AppTypo.generalSans,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    '1290 points left to become Gold Member',
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: AppTypo.generalSans,
                      height: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 192,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: const [
                    _PromoBannerCard(
                      backgroundColor: Color(0xFF5A57A5),
                      tagText: 'New shop',
                      title: 'We are now at\nCentral Boulevard',
                      placeholderColor: Color(0xFF8A87C7),
                    ),
                    SizedBox(width: 14),
                    _PromoBannerCard(
                      backgroundColor: Color(0xFF5BC0EB),
                      tagText: '50% off',
                      title: 'Hot deals for\nthe weekend',
                      placeholderColor: Color(0xFF8ED6F4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PromoBannerCard extends StatelessWidget {
  final Color backgroundColor;
  final String tagText;
  final String title;
  final Color placeholderColor;

  const _PromoBannerCard({
    required this.backgroundColor,
    required this.tagText,
    required this.title,
    required this.placeholderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF37B2B),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 1.2),
            ),
            child: Text(
              tagText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: AppTypo.generalSans,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: AppTypo.menco,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          Spacer(),
          Container(
            height: 64,
            width: 190,
            decoration: BoxDecoration(
              color: placeholderColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
