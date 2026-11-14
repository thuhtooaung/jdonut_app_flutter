import 'package:flutter/material.dart';
import '../../domain/models/home_data_entity.dart';

class PromoBannerModel {
  final String id;
  final String title;
  final String tagText;
  final String backgroundColorHex;
  final String imageUrl;

  const PromoBannerModel({
    required this.id,
    required this.title,
    required this.tagText,
    required this.backgroundColorHex,
    required this.imageUrl,
  });

  factory PromoBannerModel.fromJson(Map<String, dynamic> json) {
    return PromoBannerModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      tagText: json['tag_text'] as String? ?? '',
      backgroundColorHex: json['background_color'] as String? ?? '#5A57A5',
      imageUrl: json['image_url'] as String? ?? '',
    );
  }

  static Color _parseColor(String hexString) {
    final buffer = StringBuffer();
    final cleanHex = hexString.replaceFirst('#', '');
    if (cleanHex.length == 6) buffer.write('ff');
    buffer.write(cleanHex);
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  PromoBannerEntity toEntity() {
    return PromoBannerEntity(
      id: id,
      title: title,
      tagText: tagText,
      backgroundColor: _parseColor(backgroundColorHex),
      imageUrl: imageUrl,
    );
  }
}

class SeasonalSpecialModel {
  final String id;
  final String title;
  final String imageUrl;
  final String? discountTag;

  const SeasonalSpecialModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.discountTag,
  });

  factory SeasonalSpecialModel.fromJson(Map<String, dynamic> json) {
    return SeasonalSpecialModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      discountTag: json['discount_tag'] as String?,
    );
  }

  SeasonalSpecialEntity toEntity() {
    return SeasonalSpecialEntity(
      id: id,
      title: title,
      imageUrl: imageUrl,
      discountTag: discountTag,
    );
  }
}

class PopularItemModel {
  final String id;
  final String title;
  final String imageUrl;
  final String? price;

  const PopularItemModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.price,
  });

  factory PopularItemModel.fromJson(Map<String, dynamic> json) {
    return PopularItemModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      price: json['price'] as String?,
    );
  }

  PopularItemEntity toEntity() {
    return PopularItemEntity(
      id: id,
      title: title,
      imageUrl: imageUrl,
      price: price,
    );
  }
}

class OrderAgainItemModel {
  final String id;
  final String title;
  final String imageUrl;
  final String? discountTag;

  const OrderAgainItemModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.discountTag,
  });

  factory OrderAgainItemModel.fromJson(Map<String, dynamic> json) {
    return OrderAgainItemModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      discountTag: json['discount_tag'] as String?,
    );
  }

  OrderAgainItemEntity toEntity() {
    return OrderAgainItemEntity(
      id: id,
      title: title,
      imageUrl: imageUrl,
      discountTag: discountTag,
    );
  }
}

class NearbyShopModel {
  final String id;
  final String title;
  final String address;
  final String actionText;
  final String imageUrl;

  const NearbyShopModel({
    required this.id,
    required this.title,
    required this.address,
    required this.actionText,
    required this.imageUrl,
  });

  factory NearbyShopModel.fromJson(Map<String, dynamic> json) {
    return NearbyShopModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      address: json['address'] as String? ?? '',
      actionText: json['action_text'] as String? ?? 'Order Online',
      imageUrl: json['image_url'] as String? ?? '',
    );
  }

  NearbyShopEntity toEntity() {
    return NearbyShopEntity(
      id: id,
      title: title,
      address: address,
      actionText: actionText,
      imageUrl: imageUrl,
    );
  }
}

class HomeDataModel {
  final List<PromoBannerModel> promoBanners;
  final List<SeasonalSpecialModel> seasonalSpecials;
  final List<PopularItemModel> popularItems;
  final List<OrderAgainItemModel> orderAgainItems;
  final List<NearbyShopModel> nearbyShops;

  const HomeDataModel({
    required this.promoBanners,
    required this.seasonalSpecials,
    required this.popularItems,
    required this.orderAgainItems,
    required this.nearbyShops,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    final promoList = (json['promo_banners'] as List<dynamic>?)
            ?.map((e) => PromoBannerModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    final seasonalList = (json['seasonal_specials'] as List<dynamic>?)
            ?.map((e) => SeasonalSpecialModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    final popularList = (json['popular_items'] as List<dynamic>?)
            ?.map((e) => PopularItemModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    final orderAgainList = (json['order_again_items'] as List<dynamic>?)
            ?.map((e) => OrderAgainItemModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    final nearbyShopsList = (json['nearby_shops'] as List<dynamic>?)
            ?.map((e) => NearbyShopModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    return HomeDataModel(
      promoBanners: promoList,
      seasonalSpecials: seasonalList,
      popularItems: popularList,
      orderAgainItems: orderAgainList,
      nearbyShops: nearbyShopsList,
    );
  }

  HomeDataEntity toEntity() {
    return HomeDataEntity(
      promoBanners: promoBanners.map((e) => e.toEntity()).toList(),
      seasonalSpecials: seasonalSpecials.map((e) => e.toEntity()).toList(),
      popularItems: popularItems.map((e) => e.toEntity()).toList(),
      orderAgainItems: orderAgainItems.map((e) => e.toEntity()).toList(),
      nearbyShops: nearbyShops.map((e) => e.toEntity()).toList(),
    );
  }
}
