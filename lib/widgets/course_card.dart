import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'common.dart';

/// Card showing a programme icon, name, short description and category.
class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.icon,
    required this.name,
    required this.description,
    required this.category,
  });

  final IconData icon;
  final String name;
  final String description;
  final String category;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconBadge(icon: icon),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                height: 1.3,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14.5,
                height: 1.5,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
