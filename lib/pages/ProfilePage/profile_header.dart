import 'package:flutter/material.dart';

Widget profileHeader(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 20, 24, 24),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  offset: const Offset(0, 4),
                ),
              ],
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                'https://images.unsplash.com/photo-1592520113018-180c8bc831c9?ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Elaine Edwards',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'elaine.edwards@google.com',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    ),
  );
}
