import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/info_card.dart';
import '../widgets/page_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PageBanner(
            title: 'About Bansal Institute of Engineering & Technology',
          ),
          _AboutInstitute(),
          _VisionMission(),
          _Infrastructure(),
        ],
      ),
    );
  }
}

class _AboutInstitute extends StatelessWidget {
  const _AboutInstitute();

  @override
  Widget build(BuildContext context) {
    final bool wide = MediaQuery.of(context).size.width >= 900;

    const Widget text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(title: 'About the Institute', centered: false),
        SizedBox(height: 16),
        Text(
          'Bansal Institute of Engineering & Technology (BIET) was '
          'established in 2007 and is managed by Bansal Educational Trust. '
          'The institute is located in Lucknow, Uttar Pradesh.',
          style: TextStyle(
            fontSize: 16.5,
            height: 1.7,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 14),
        Text(
          'BIET is affiliated with Dr. A.P.J. Abdul Kalam Technical '
          'University (AKTU), Lucknow, and has approval from AICTE. It aims '
          'to provide quality technical education and develop skilled '
          'professionals.',
          style: TextStyle(
            fontSize: 16.5,
            height: 1.7,
            color: AppColors.textDark,
          ),
        ),
      ],
    );

    const Widget facts = AppCard(
      color: AppColors.lightBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Facts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.navy,
            ),
          ),
          SizedBox(height: 16),
          _FactRow(label: 'Established', value: '2007'),
          _FactRow(label: 'Managed by', value: 'Bansal Educational Trust'),
          _FactRow(label: 'Affiliation', value: 'AKTU, Lucknow'),
          _FactRow(label: 'Approval', value: 'AICTE'),
          _FactRow(label: 'Location', value: 'Lucknow, Uttar Pradesh'),
        ],
      ),
    );

    return PageSection(
      child: wide
          ? const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: text),
                SizedBox(width: 40),
                Expanded(flex: 2, child: facts),
              ],
            )
          : const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                text,
                SizedBox(height: 28),
                facts,
              ],
            ),
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 104,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.navy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VisionMission extends StatelessWidget {
  const _VisionMission();

  @override
  Widget build(BuildContext context) {
    return const PageSection(
      color: AppColors.grey,
      child: Column(
        children: [
          SectionHeading(title: 'Vision & Mission'),
          SizedBox(height: 32),
          ResponsiveWrap(
            minItemWidth: 420,
            maxColumns: 2,
            children: [
              _VisionCard(),
              _MissionCard(),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'The vision and mission statements are proposed website content '
            'and are not verified official quotations.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _VisionCard extends StatelessWidget {
  const _VisionCard();

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconBadge(icon: Icons.visibility_outlined),
          SizedBox(height: 16),
          Text(
            'Vision',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.navy,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'To develop technically competent, innovative and responsible '
            'professionals who contribute to society.',
            style: TextStyle(
              fontSize: 15.5,
              height: 1.6,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  const _MissionCard();

  static const List<String> _points = [
    'Provide quality technical education.',
    'Encourage practical learning and innovation.',
    'Develop professional and ethical values.',
    'Prepare students for industry and higher education.',
  ];

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IconBadge(icon: Icons.flag_outlined),
          const SizedBox(height: 16),
          const Text(
            'Mission',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(height: 10),
          for (final String point in _points)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(
                        fontSize: 15.5,
                        height: 1.5,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Infrastructure extends StatelessWidget {
  const _Infrastructure();

  @override
  Widget build(BuildContext context) {
    return const PageSection(
      child: Column(
        children: [
          SectionHeading(
            title: 'Infrastructure',
            subtitle: 'Spaces that support teaching, learning and campus life.',
          ),
          SizedBox(height: 32),
          ResponsiveWrap(
            minItemWidth: 240,
            maxColumns: 4,
            children: [
              InfoCard(
                icon: Icons.meeting_room_outlined,
                title: 'Modern Classrooms',
                text: 'Learning spaces for lectures and academic activities.',
                imagePath: 'assets/images/classrooms.jpg',
                minHeight: 290,
              ),
              InfoCard(
                icon: Icons.computer_outlined,
                title: 'Computer Laboratories',
                text: 'Laboratories for practical computing work.',
                imagePath: 'assets/images/computer_lab.jpg',
                minHeight: 290,
              ),
              InfoCard(
                icon: Icons.local_library_outlined,
                title: 'Library',
                text: 'A place for reading, reference and study.',
                imagePath: 'assets/images/library.jpg',
                minHeight: 290,
              ),
              InfoCard(
                icon: Icons.domain_outlined,
                title: 'Campus Facilities',
                text: 'Facilities that support student life on campus.',
                imagePath: 'assets/images/facilities.jpg',
                minHeight: 290,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
