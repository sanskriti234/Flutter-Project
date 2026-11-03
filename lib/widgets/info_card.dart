import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'common.dart';

/// Card with a title and optional text.
/// - Without [imagePath]: shows an icon badge above the title.
/// - With [imagePath]: shows the image on top (or a placeholder if the file
///   is missing), then the title and text.
class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    this.text,
    this.imagePath,
    this.minHeight = 0,
  });

  final IconData icon;
  final String title;
  final String? text;
  final String? imagePath;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imagePath != null;

    return AppCard(
      padding: EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage)
              AppImage(
                path: imagePath!,
                label: title,
                icon: icon,
                height: 170,
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!hasImage) ...[
                    IconBadge(icon: icon),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navy,
                    ),
                  ),
                  if (text != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      text!,
                      style: const TextStyle(
                        fontSize: 14.5,
                        height: 1.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
