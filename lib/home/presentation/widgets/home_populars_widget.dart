import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonut_app_flutter/routing/routes.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

import '../../domain/models/home_data_entity.dart';
import '../models/product_args.dart';
import 'home_section_header_widget.dart';

class HomePopularsWidget extends StatelessWidget {
  final List<PopularItemEntity> items;

  const HomePopularsWidget({
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
        padding: const EdgeInsets.only(bottom: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeSectionHeaderWidget(title: 'Popular 🔥'),
            const SizedBox(height: 16),
            SizedBox(
              height: 320,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: items.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _VerticalProductCard(item: item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VerticalProductCard extends StatelessWidget {
  final PopularItemEntity item;

  const _VerticalProductCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          Routes.product,
          extra: ProductArgs(
            id: item.id,
            name: item.title.replaceAll('\n', ' '),
            discountTag: 'Popular 🔥',
            price: item.price ?? '3,200 MMK',
            imageUrl: item.imageUrl,
            description:
                'One of our top-rated customer favorites! Deliciously crafted to provide an exceptional taste experience.',
            productCode: 'JD-${item.id.toUpperCase()}02',
          ),
        );
      },
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 240,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xFFFCE4EC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: const Color(0xFFFCE4EC),
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: const Color(0xFFFCE4EC),
                  child: const Center(
                    child: Icon(Icons.donut_large, color: Colors.grey, size: 40),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
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
