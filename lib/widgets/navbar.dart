import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'common.dart';

/// One entry in the site navigation.
class NavItem {
  const NavItem(this.label, this.route, this.icon);

  final String label;
  final String route;
  final IconData icon;
}

const List<NavItem> navItems = [
  NavItem('Home', '/', Icons.home_outlined),
  NavItem('About Us', '/about', Icons.info_outline),
  NavItem('Courses', '/courses', Icons.menu_book_outlined),
  NavItem('Contact Us', '/contact', Icons.mail_outline),
];

/// Route name of the page that [context] belongs to.
String currentRouteOf(BuildContext context) =>
    ModalRoute.of(context)?.settings.name ?? '/';

/// Navigates to [route] unless it is already the current page.
void goTo(BuildContext context, String route) {
  if (currentRouteOf(context) == route) return;
  Navigator.of(context).pushReplacementNamed(route);
}

/// Navigation bar shown at the top of every page.
/// Shows links on wide screens and a menu button (drawer) on small screens.
class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  static const double height = 72;

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final String current = currentRouteOf(context);
    final bool wide = MediaQuery.of(context).size.width >= 900;

    return Material(
      color: Colors.white,
      elevation: 3,
      shadowColor: const Color(0x33102A43),
      child: SizedBox(
        height: height,
        child: ContentWidth(
          maxWidth: 1250,
          child: Row(
            children: [
              const Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _Brand(),
                ),
              ),
              if (wide) ...[
                for (final NavItem item in navItems)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: _NavLink(item: item, active: item.route == current),
                  ),
              ] else
                Builder(
                  builder: (ctx) => IconButton(
                    tooltip: 'Menu',
                    icon: const Icon(Icons.menu, color: AppColors.navy),
                    onPressed: () => Scaffold.of(ctx).openDrawer(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Simple text-based logo: "BIET" badge plus the institute name.
class _Brand extends StatelessWidget {
  const _Brand({this.light = false});

  final bool light;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => goTo(context, '/'),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46,
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: light ? Colors.white : AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'BIET',
                style: TextStyle(
                  color: light ? AppColors.navy : Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                'Bansal Institute of Engineering & Technology',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: light ? Colors.white : AppColors.navy,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.item, required this.active});

  final NavItem item;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => goTo(context, item.route),
      style: TextButton.styleFrom(
        foregroundColor: active ? AppColors.primary : AppColors.navy,
        backgroundColor: active ? AppColors.lightBlue : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: TextStyle(
          fontSize: 15,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      child: Text(item.label),
    );
  }
}

/// Side menu used on small screens.
class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final String current = currentRouteOf(context);

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.navy,
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 20),
            child: const _Brand(light: true),
          ),
          const SizedBox(height: 12),
          for (final NavItem item in navItems)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: ListTile(
                leading: Icon(item.icon, color: AppColors.navy),
                title: Text(
                  item.label,
                  style: TextStyle(
                    color: AppColors.navy,
                    fontWeight:
                        item.route == current ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
                selected: item.route == current,
                selectedTileColor: AppColors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: () {
                  final NavigatorState navigator = Navigator.of(context);
                  final String route = item.route;
                  navigator.pop(); // close the drawer
                  if (route != current) {
                    navigator.pushReplacementNamed(route);
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
