import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/theme/app_assets.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

import '../../domain/models/home_data_entity.dart';

class HomeNearbyShopsWidget extends StatelessWidget {
  final List<NearbyShopEntity> shops;

  const HomeNearbyShopsWidget({
    super.key,
    required this.shops,
  });

  @override
  Widget build(BuildContext context) {
    final shopCount = shops.length;

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
                    "There are $shopCount J'Donut shops near you.",
                    style: const TextStyle(
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
                      foregroundColor: const Color(0xFF33CEF7),
                    ),
                    child: const Text(
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
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    itemCount: shops.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final shop = shops[index];
                      return _StoreLocationCard(shop: shop);
                    },
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
  final NearbyShopEntity shop;

  const _StoreLocationCard({required this.shop});

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
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFFE0F7FA),
              borderRadius: BorderRadius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl: shop.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: const Color(0xFFE0F7FA),
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: const Color(0xFFE0F7FA),
                child: const Center(
                  child: Icon(Icons.store, color: Colors.grey, size: 40),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            shop.title,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: AppTypo.generalSans,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            shop.address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontFamily: AppTypo.generalSans,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            shop.actionText,
            style: const TextStyle(
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
