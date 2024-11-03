import 'package:flutter/material.dart';
import 'profile_page_model.dart';

Widget themeSwitcher(BuildContext context, ProfilePageModel model) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => model.toggleDarkMode(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        model.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      model.isDarkMode ? 'Dark Mode' : 'Light Mode',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Switch(
                  value: model.isDarkMode,
                  onChanged: (_) => model.toggleDarkMode(),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}