import 'package:flutter/material.dart';
import '../theme/app_typo.dart';

class NavItemData {
  final IconData icon;
  final String label;

  const NavItemData({required this.icon, required this.label});
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final List<NavItemData> items;
  final ValueChanged<int> onItemSelected;
  final Color backgroundColor;
  final Color selectedItemColor;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
    this.backgroundColor = const Color(0xFF4CD4F7),
    this.selectedItemColor = const Color(0xFFF65D9E),
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(width: double.infinity, height: 40, color: Colors.pink),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              border: const Border(
                top: BorderSide(color: Colors.white, width: 2),
                left: BorderSide(color: Colors.white, width: 2),
                right: BorderSide(color: Colors.white, width: 2),
                bottom: BorderSide.none,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (index) {
                  final isSelected = index == selectedIndex;
                  final item = items[index];

                  return GestureDetector(
                    onTap: () => onItemSelected(index),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSelected ? 12 : 8,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? selectedItemColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(item.icon, color: Colors.white, size: 20),
                            if (isSelected) ...[
                              const SizedBox(width: 4),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 96),
                                child: Text(
                                  item.label,
                                  style: Theme.of(context).textTheme.labelMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
