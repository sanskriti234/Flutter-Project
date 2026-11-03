import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/info_card.dart';
import '../widgets/navbar.dart';
import '../widgets/page_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeroSection(),
          _AboutPreview(),
          _HighlightsSection(),
          _CampusLifeSection(),
        ],
      ),
    );
  }
}

/// Large hero with a campus background image (placeholder colour if the
/// image file is missing), heading, subtitle and two buttons.
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final bool mobile = isMobileWidth(context);

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/hero.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: AppColors.navy),
          ),
        ),
        // Dark navy overlay so the white text is always readable.
        Positioned.fill(
          child: Container(color: const Color(0xB3102A43)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: mobile ? 64 : 120),
          child: ContentWidth(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 780),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Bansal Institute of Engineering & Technology',
                      style: TextStyle(
                        fontSize: mobile ? 30 : 46,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Building Future Engineers Through Quality Education '
                      'and Innovation.',
                      style: TextStyle(
                        fontSize: 19,
                        height: 1.5,
                        color: Color(0xFFD6E4F2),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 16,
                      runSpacing: 14,
                      children: [
                        FilledButton.icon(
                          onPressed: () => goTo(context, '/courses'),
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Explore Courses'),
                        ),
                        OutlinedButton(
                          onPressed: () => goTo(context, '/contact'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.white,
                              width: 1.5,
                            ),
                          ),
                          child: const Text('Contact Us'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Short introduction with a "Read More" button that opens the About page.
class _AboutPreview extends StatelessWidget {
  const _AboutPreview();

  @override
  Widget build(BuildContext context) {
    final bool wide = MediaQuery.of(context).size.width >= 900;

    final Widget text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(title: 'About the Institute', centered: false),
        const SizedBox(height: 16),
        const Text(
          'Bansal Institute of Engineering & Technology, Lucknow, was '
          'established in 2007 under Bansal Educational Trust. The institute '
          'is affiliated with Dr. A.P.J. Abdul Kalam Technical University and '
          'approved by AICTE. It aims to provide quality technical education '
          'and develop skilled professionals.',
          style: TextStyle(
            fontSize: 16.5,
            height: 1.7,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: () => goTo(context, '/about'),
          child: const Text('Read More'),
        ),
      ],
    );

    const Widget image = AppImage(
      path: 'assets/images/campus.jpg',
      label: 'Campus',
      icon: Icons.apartment_outlined,
      height: 300,
      borderRadius: BorderRadius.all(Radius.circular(16)),
    );

    return PageSection(
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 3, child: text),
                const SizedBox(width: 48),
                const Expanded(flex: 2, child: image),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                text,
                const SizedBox(height: 28),
                image,
              ],
            ),
    );
  }
}

class _HighlightsSection extends StatelessWidget {
  const _HighlightsSection();

  @override
  Widget build(BuildContext context) {
    return const PageSection(
      color: AppColors.grey,
      child: Column(
        children: [
          SectionHeading(title: 'Institute Highlights'),
          SizedBox(height: 32),
          ResponsiveWrap(
            minItemWidth: 240,
            maxColumns: 4,
            children: [
              InfoCard(
                icon: Icons.calendar_month_outlined,
                title: 'Established in 2007',
                text: 'Managed by Bansal Educational Trust, Lucknow.',
                minHeight: 200,
              ),
              InfoCard(
                icon: Icons.account_balance_outlined,
                title: 'AKTU Affiliated',
                text: 'Affiliated with Dr. A.P.J. Abdul Kalam Technical '
                    'University, Lucknow.',
                minHeight: 200,
              ),
              InfoCard(
                icon: Icons.verified_outlined,
                title: 'AICTE Approved',
                text: 'Approved by the All India Council for Technical '
                    'Education.',
                minHeight: 200,
              ),
              InfoCard(
                icon: Icons.engineering_outlined,
                title: 'Engineering Education',
                text: 'Programmes in engineering, technology and management.',
                minHeight: 200,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CampusLifeSection extends StatelessWidget {
  const _CampusLifeSection();

  @override
  Widget build(BuildContext context) {
    return const PageSection(
      child: Column(
        children: [
          SectionHeading(
            title: 'Campus Life',
            subtitle: 'A glimpse of learning and student life at BIET.',
          ),
          SizedBox(height: 32),
          ResponsiveWrap(
            minItemWidth: 240,
            maxColumns: 4,
            children: [
              InfoCard(
                icon: Icons.apartment_outlined,
                title: 'Campus Infrastructure',
                imagePath: 'assets/images/campus.jpg',
              ),
              InfoCard(
                icon: Icons.science_outlined,
                title: 'Engineering Laboratories',
                imagePath: 'assets/images/labs.jpg',
              ),
              InfoCard(
                icon: Icons.local_library_outlined,
                title: 'Library',
                imagePath: 'assets/images/library.jpg',
              ),
              InfoCard(
                icon: Icons.groups_outlined,
                title: 'Student Activities',
                imagePath: 'assets/images/student_activities.jpg',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
