import 'package:flutter/material.dart';

class PromoBannerEntity {
  final String id;
  final String title;
  final String tagText;
  final Color backgroundColor;
  final String imageUrl;

  const PromoBannerEntity({
    required this.id,
    required this.title,
    required this.tagText,
    required this.backgroundColor,
    required this.imageUrl,
  });
}

class SeasonalSpecialEntity {
  final String id;
  final String title;
  final String imageUrl;
  final String? discountTag;

  const SeasonalSpecialEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.discountTag,
  });
}

class PopularItemEntity {
  final String id;
  final String title;
  final String imageUrl;
  final String? price;

  const PopularItemEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.price,
  });
}

class OrderAgainItemEntity {
  final String id;
  final String title;
  final String imageUrl;
  final String? discountTag;

  const OrderAgainItemEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.discountTag,
  });
}

class NearbyShopEntity {
  final String id;
  final String title;
  final String address;
  final String actionText;
  final String imageUrl;

  const NearbyShopEntity({
    required this.id,
    required this.title,
    required this.address,
    required this.actionText,
    required this.imageUrl,
  });
}

class HomeDataEntity {
  final List<PromoBannerEntity> promoBanners;
  final List<SeasonalSpecialEntity> seasonalSpecials;
  final List<PopularItemEntity> popularItems;
  final List<OrderAgainItemEntity> orderAgainItems;
  final List<NearbyShopEntity> nearbyShops;

  const HomeDataEntity({
    required this.promoBanners,
    required this.seasonalSpecials,
    required this.popularItems,
    required this.orderAgainItems,
    required this.nearbyShops,
  });
}
