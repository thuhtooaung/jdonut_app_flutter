import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/home/widgets/home_app_bar_widget.dart';
import 'package:jdonut_app_flutter/home/widgets/home_nearby_shops_widget.dart';
import 'package:jdonut_app_flutter/home/widgets/home_order_again_widget.dart';
import 'package:jdonut_app_flutter/home/widgets/home_populars_widget.dart';
import 'package:jdonut_app_flutter/home/widgets/home_seasonal_specials_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            HomeAppBarWidget(),

            // First Section: Seasonal Specials
            HomeSeasonalSpecialsWidget(),

            // Third Section: Popular 🔥
            HomePopularsWidget(),

            // Fourth Section: Order again
            HomeOrderAgainWidget(),

            // Fifth Section: Explore Now / Store Locations Banner Section
            HomeNearbyShopsWidget(),
          ],
        ),
        Positioned(
          top: 96,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Row(
              spacing: 4,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.notifications_outlined, color: Colors.white),
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
