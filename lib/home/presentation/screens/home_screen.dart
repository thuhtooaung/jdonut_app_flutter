import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/home_provider.dart';
import '../widgets/home_app_bar_widget.dart';
import '../widgets/home_nearby_shops_widget.dart';
import '../widgets/home_order_again_widget.dart';
import '../widgets/home_populars_widget.dart';
import '../widgets/home_seasonal_specials_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeDataAsync = ref.watch(homeDataProvider);

    return Stack(
      children: [
        homeDataAsync.when(
          data: (homeData) => CustomScrollView(
            slivers: [
              HomeAppBarWidget(promoBanners: homeData.promoBanners),

              // First Section: Seasonal Specials
              HomeSeasonalSpecialsWidget(items: homeData.seasonalSpecials),

              // Second Section: Popular 🔥
              HomePopularsWidget(items: homeData.popularItems),

              // Third Section: Order again
              HomeOrderAgainWidget(items: homeData.orderAgainItems),

              // Fourth Section: Explore Now / Store Locations Banner Section
              HomeNearbyShopsWidget(shops: homeData.nearbyShops),
            ],
          ),
          loading: () => const CustomScrollView(
            slivers: [
              HomeAppBarWidget(),
              SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
          error: (error, stackTrace) => CustomScrollView(
            slivers: [
              const HomeAppBarWidget(),
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load home data: $error',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.refresh(homeDataProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 96,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange,
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Row(
              spacing: 4,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.notifications_outlined, color: Colors.white),
                Badge.count(
                  count: 2,
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
