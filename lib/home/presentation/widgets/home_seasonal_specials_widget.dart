import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonut_app_flutter/routing/routes.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

import '../../domain/models/home_data_entity.dart';
import '../models/product_args.dart';
import 'home_section_header_widget.dart';

class HomeSeasonalSpecialsWidget extends StatelessWidget {
  final List<SeasonalSpecialEntity> items;

  const HomeSeasonalSpecialsWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

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
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: items.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _SeasonalProductCard(item: item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeasonalProductCard extends StatelessWidget {
  final SeasonalSpecialEntity item;

  const _SeasonalProductCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          Routes.product,
          extra: ProductArgs(
            id: item.id,
            name: item.title.replaceAll('\n', ' '),
            discountTag: item.discountTag ?? 'Seasonal',
            imageUrl: item.imageUrl,
            price: '3,200 MMK',
            description:
                'Handcrafted seasonal special donut prepared with premium glaze, topped with holiday festivities, and baked to perfection.',
            productCode: 'JD-${item.id.toUpperCase()}01',
          ),
        );
      },
      child: SizedBox(
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
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2D8D0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: item.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: const Color(0xFFE2D8D0),
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: const Color(0xFFE2D8D0),
                      child: const Center(
                        child: Icon(Icons.fastfood, color: Colors.grey, size: 40),
                      ),
                    ),
                  ),
                ),
                if (item.discountTag != null && item.discountTag!.isNotEmpty)
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
                        item.discountTag!,
                        style: const TextStyle(
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
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: AppTypo.generalSans,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
