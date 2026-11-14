import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/home/home_screen.dart';
import 'package:jdonut_app_flutter/rewards/rewards_screen.dart';
import 'package:jdonut_app_flutter/widgets/custom_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    RewardsScreen(),
    TabPlaceholderScreen(
      title: 'Explore',
      icon: Icons.catching_pokemon,
      backgroundColor: Color(0xFFF0FDF4),
      accentColor: Color(0xFF10B981),
    ),
    TabPlaceholderScreen(
      title: 'Wallet',
      icon: Icons.account_balance_wallet_outlined,
      backgroundColor: Color(0xFFFEFCE8),
      accentColor: Color(0xFFF59E0B),
    ),
    TabPlaceholderScreen(
      title: 'Settings',
      icon: Icons.settings,
      backgroundColor: Color(0xFFF5F3FF),
      accentColor: Color(0xFF8B5CF6),
    ),
  ];

  final List<NavItemData> _navItems = const [
    NavItemData(icon: Icons.home, label: 'Home'),
    NavItemData(icon: Icons.card_giftcard, label: 'Reward'),
    NavItemData(icon: Icons.catching_pokemon, label: 'Explore'),
    NavItemData(icon: Icons.account_balance_wallet_outlined, label: 'Wallet'),
    NavItemData(icon: Icons.settings, label: 'Settings Setting Setting'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom + 40,
        ),
        child: IndexedStack(index: _selectedIndex, children: _screens),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        items: _navItems,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class TabPlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color accentColor;

  const TabPlaceholderScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 64, color: accentColor),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.grey.shade800),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome to the $title screen',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
