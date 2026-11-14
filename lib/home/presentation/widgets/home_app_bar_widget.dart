import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

import '../../domain/models/home_data_entity.dart';

class HomeAppBarWidget extends StatelessWidget {
  final List<PromoBannerEntity> promoBanners;

  const HomeAppBarWidget({
    super.key,
    this.promoBanners = const [],
  });

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
          decoration: const BoxDecoration(
            color: Color(0xFFFDEEE2),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          foregroundDecoration: const BoxDecoration(
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
                    const Column(
                      spacing: 6,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                child: promoBanners.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: promoBanners.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 14),
                        itemBuilder: (context, index) {
                          final banner = promoBanners[index];
                          return _PromoBannerCard(banner: banner);
                        },
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
  final PromoBannerEntity banner;

  const _PromoBannerCard({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: banner.backgroundColor,
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
              banner.tagText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: AppTypo.generalSans,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            banner.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: AppTypo.menco,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const Spacer(),
          Container(
            height: 64,
            width: 190,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: banner.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.white24,
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.white24,
                child: const Center(
                  child: Icon(Icons.broken_image, color: Colors.white70),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
