import 'dart:convert';
import '../models/home_data_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeDataModel> getHomeData();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const String _imagePlaceholder =
      'https://images.pexels.com/photos/23203429/pexels-photo-23203429.jpeg';

  static const String _dummyJsonResponse = '''
  {
    "promo_banners": [
      {
        "id": "b1",
        "title": "We are now at\\nCentral Boulevard",
        "tag_text": "New shop",
        "background_color": "#5A57A5",
        "image_url": "$_imagePlaceholder"
      },
      {
        "id": "b2",
        "title": "Hot deals for\\nthe weekend",
        "tag_text": "50% off",
        "background_color": "#5BC0EB",
        "image_url": "$_imagePlaceholder"
      }
    ],
    "seasonal_specials": [
      {
        "id": "s1",
        "title": "Mistletoe\\nRomance box",
        "image_url": "$_imagePlaceholder",
        "discount_tag": "50% off"
      },
      {
        "id": "s2",
        "title": "Christmas Mix\\nFamily box",
        "image_url": "$_imagePlaceholder",
        "discount_tag": null
      },
      {
        "id": "s3",
        "title": "Winter Glaze\\nSpecial pack",
        "image_url": "$_imagePlaceholder",
        "discount_tag": "20% off"
      }
    ],
    "popular_items": [
      {
        "id": "p1",
        "title": "Strawberry\\nChocolate Donuts",
        "image_url": "$_imagePlaceholder",
        "price": "\$4.99"
      },
      {
        "id": "p2",
        "title": "Dalgona Creamy\\nCoffee",
        "image_url": "$_imagePlaceholder",
        "price": "\$3.49"
      },
      {
        "id": "p3",
        "title": "Matcha Green\\nTea Latte",
        "image_url": "$_imagePlaceholder",
        "price": "\$3.99"
      }
    ],
    "order_again_items": [
      {
        "id": "o1",
        "title": "Santa’s favorite\\ncookies set",
        "image_url": "$_imagePlaceholder",
        "discount_tag": "20% off"
      },
      {
        "id": "o2",
        "title": "Classic Glazed\\nBox of 6",
        "image_url": "$_imagePlaceholder",
        "discount_tag": "10% off"
      },
      {
        "id": "o3",
        "title": "Holiday Special\\nCocoa Pack",
        "image_url": "$_imagePlaceholder",
        "discount_tag": "15% off"
      }
    ],
    "nearby_shops": [
      {
        "id": "ns1",
        "title": "Myaynigone J'Donut",
        "address": "2972 Pyay Road, Sanchaung\\nTownship, Yangon.",
        "action_text": "Order Online",
        "image_url": "$_imagePlaceholder"
      },
      {
        "id": "ns2",
        "title": "Downtown J'Donut",
        "address": "45 Sule Pagoda Road, Kyauktada\\nTownship, Yangon.",
        "action_text": "Order Online",
        "image_url": "$_imagePlaceholder"
      },
      {
        "id": "ns3",
        "title": "Yankin J'Donut",
        "address": "12 Yankin Road, Yankin\\nTownship, Yangon.",
        "action_text": "Order Online",
        "image_url": "$_imagePlaceholder"
      }
    ]
  }
  ''';

  @override
  Future<HomeDataModel> getHomeData() async {
    // Simulate API network delay
    await Future.delayed(const Duration(milliseconds: 600));
    final Map<String, dynamic> decoded = jsonDecode(_dummyJsonResponse);
    return HomeDataModel.fromJson(decoded);
  }
}
