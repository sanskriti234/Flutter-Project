import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

/// Opens [url] in a new browser tab / external app.
Future<void> openLink(String url) async {
  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

/// True on phone-sized screens.
bool isMobileWidth(BuildContext context) =>
    MediaQuery.of(context).size.width < 600;

/// Centres content and limits its width, with a responsive side gutter.
class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child, this.maxWidth = 1150});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final double gutter = isMobileWidth(context) ? 16 : 32;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: gutter),
          child: child,
        ),
      ),
    );
  }
}

/// Full-width page section with a background colour and vertical spacing.
class PageSection extends StatelessWidget {
  const PageSection({
    super.key,
    required this.child,
    this.color = Colors.white,
  });

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double vertical = isMobileWidth(context) ? 40 : 64;
    return Container(
      width: double.infinity,
      color: color,
      padding: EdgeInsets.symmetric(vertical: vertical),
      child: ContentWidth(child: child),
    );
  }
}

/// Lays children out in a grid whose column count adapts to the width.
class ResponsiveWrap extends StatelessWidget {
  const ResponsiveWrap({
    super.key,
    required this.children,
    this.minItemWidth = 280,
    this.spacing = 24,
    this.maxColumns = 3,
  });

  final List<Widget> children;
  final double minItemWidth;
  final double spacing;
  final int maxColumns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        int columns = ((width + spacing) / (minItemWidth + spacing)).floor();
        if (columns < 1) columns = 1;
        if (columns > maxColumns) columns = maxColumns;
        final double itemWidth =
            ((width - spacing * (columns - 1)) / columns).floorToDouble();

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final Widget child in children)
              SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}

/// Rounded white card with a thin border and a subtle shadow.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.color = Colors.white,
    this.borderColor = AppColors.border,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14102A43),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Icon inside a light-blue rounded square.
class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.icon,
    this.size = 52,
    this.background = AppColors.lightBlue,
    this.foreground = AppColors.primary,
  });

  final IconData icon;
  final double size;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: foreground, size: size * 0.52),
    );
  }
}

/// Shows a local asset image. If the file is missing or cannot load, a clean
/// placeholder is shown instead of a broken-image icon.
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.path,
    required this.label,
    required this.icon,
    this.height = 180,
    this.borderRadius = BorderRadius.zero,
  });

  final String path;
  final String label;
  final IconData icon;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _ImagePlaceholder(label: label, icon: icon),
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightBlue,
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44, color: AppColors.primary),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.navy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Banner with the page heading, used at the top of inner pages.
class PageBanner extends StatelessWidget {
  const PageBanner({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final bool mobile = isMobileWidth(context);
    return Container(
      width: double.infinity,
      color: AppColors.navy,
      padding: EdgeInsets.symmetric(vertical: mobile ? 40 : 64),
      child: ContentWidth(
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: mobile ? 26 : 38,
                fontWeight: FontWeight.w700,
                height: 1.2,
                color: Colors.white,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 14),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.5,
                    height: 1.5,
                    color: Color(0xFFC9D8E8),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Centred or left-aligned section title with an optional subtitle.
class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.subtitle,
    this.centered = true,
  });

  final String title;
  final String? subtitle;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final bool mobile = isMobileWidth(context);
    final TextAlign align = centered ? TextAlign.center : TextAlign.left;
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: align,
          style: TextStyle(
            fontSize: mobile ? 24 : 30,
            fontWeight: FontWeight.w700,
            color: AppColors.navy,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              subtitle!,
              textAlign: align,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: AppColors.textMuted,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
