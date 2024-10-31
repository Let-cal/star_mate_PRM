import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    // Tạo theme và text theme từ lớp MaterialTheme
    const materialTheme = MaterialTheme(TextTheme());
    final themeData = materialTheme.light();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: themeData.colorScheme.surfaceContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFooterItem(
            context,
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              debugPrint('Home clicked');
            },
          ),
          _buildFooterItem(
            context,
            icon: Icons.people,
            label: 'Friend',
            onTap: () {
              debugPrint('Friend clicked');
            },
          ),
          _buildFooterItem(
            context,
            icon: Icons.person,
            label: 'Profile',
            onTap: () {
              debugPrint('Profile clicked');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooterItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final themeData = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: themeData.colorScheme.onSurface,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: themeData.textTheme.bodySmall?.copyWith(
              color: themeData.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
