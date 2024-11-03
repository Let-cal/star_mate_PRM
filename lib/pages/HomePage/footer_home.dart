// lib/pages/HomePage/footer_home.dart
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final int activeIndex;
  final Function(int) onItemTapped;

  const Footer({
    super.key,
    required this.activeIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    // Lấy theme trực tiếp từ context thay vì tạo mới
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      // Sử dụng surfaceContainer thay vì surface để có độ tương phản tốt hơn
      color: theme.colorScheme.surfaceContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFooterItem(
            context,
            index: 0,
            icon: Icons.home,
            label: 'Home',
          ),
          _buildFooterItem(
            context,
            index: 1,
            icon: Icons.people,
            label: 'Friend',
          ),
          _buildFooterItem(
            context,
            index: 2,
            icon: Icons.person,
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildFooterItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
  }) {
    final theme = Theme.of(context);
    final isActive = activeIndex == index;

    // Màu cho item active và inactive
    final activeColor = theme.colorScheme.primary;
    final inactiveColor = theme.colorScheme.onSurfaceVariant;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? activeColor : inactiveColor,
              size: isActive ? 30 : 24,
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              style: theme.textTheme.bodySmall!.copyWith(
                color: isActive ? activeColor : inactiveColor,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
