import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'common.dart';
import 'navbar.dart';

const Color _footerText = Color(0xFFB8C7D9);

/// Footer shown at the bottom of every page.
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.navy,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 48),
            child: ContentWidth(
              child: ResponsiveWrap(
                minItemWidth: 260,
                spacing: 32,
                children: [
                  _InstituteColumn(),
                  _ContactColumn(),
                  _LinksColumn(),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0x33FFFFFF)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ContentWidth(
              child: Column(
                children: [
                  const Text(
                    'This is a student-created academic project inspired by the '
                    'official BIET website. It is not the official website of '
                    'Bansal Institute of Engineering & Technology and is not '
                    'endorsed by the institute.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _footerText, fontSize: 13, height: 1.5),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '© ${DateTime.now().year} Student Academic Project',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: _footerText, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColumnTitle extends StatelessWidget {
  const _ColumnTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _InstituteColumn extends StatelessWidget {
  const _InstituteColumn();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ColumnTitle('Bansal Institute of Engineering & Technology (BIET)'),
        Text(
          'Established in 2007 and managed by Bansal Educational Trust. '
          'Affiliated to AKTU, Lucknow and approved by AICTE.',
          style: TextStyle(color: _footerText, fontSize: 14, height: 1.6),
        ),
      ],
    );
  }
}

class _ContactColumn extends StatelessWidget {
  const _ContactColumn();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ColumnTitle('Contact'),
        _FooterLine(
          icon: Icons.location_on_outlined,
          text: 'NH-24, Sitapur Road, Behind Sewa Hospital, '
              'Lucknow, Uttar Pradesh – 226021.',
        ),
        SizedBox(height: 10),
        _FooterLine(
          icon: Icons.phone_outlined,
          text: '+91 9554 9999 37 / 38 / 39',
        ),
        SizedBox(height: 10),
        _FooterLine(
          icon: Icons.mail_outline,
          text: 'info@bansaliet.in',
        ),
      ],
    );
  }
}

class _FooterLine extends StatelessWidget {
  const _FooterLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: _footerText),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: _footerText, fontSize: 14, height: 1.5),
          ),
        ),
      ],
    );
  }
}

class _LinksColumn extends StatelessWidget {
  const _LinksColumn();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle linkStyle = TextButton.styleFrom(
      foregroundColor: _footerText,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 6),
      minimumSize: const Size(0, 32),
      textStyle: const TextStyle(fontSize: 14),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ColumnTitle('Quick Links'),
        for (final NavItem item in navItems)
          TextButton(
            style: linkStyle,
            onPressed: () => goTo(context, item.route),
            child: Text(item.label),
          ),
        TextButton(
          style: linkStyle,
          onPressed: () => openLink('https://www.bansaliet.in/'),
          child: const Text('Official BIET Website'),
        ),
      ],
    );
  }
}
