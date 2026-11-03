import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/course_card.dart';
import '../widgets/navbar.dart';
import '../widgets/page_layout.dart';

/// Simple data holder for one programme.
class _Course {
  const _Course(this.name, this.description, this.icon, this.category);

  final String name;
  final String description;
  final IconData icon;
  final String category;
}

const String _btech = 'B.Tech';
const String _pg = 'Postgraduate';

const List<_Course> _btechCourses = [
  _Course(
    'Computer Science Engineering',
    'Study of programming, software, computing systems and problem solving.',
    Icons.computer_outlined,
    _btech,
  ),
  _Course(
    'Computer Science Engineering (Artificial Intelligence)',
    'Computer science with a focus on artificial intelligence concepts.',
    Icons.smart_toy_outlined,
    _btech,
  ),
  _Course(
    'Computer Science Engineering (Artificial Intelligence & Machine Learning)',
    'Computer science with a focus on artificial intelligence and machine '
        'learning.',
    Icons.psychology_outlined,
    _btech,
  ),
  _Course(
    'Information Technology',
    'Study of information systems, networks and software technologies.',
    Icons.lan_outlined,
    _btech,
  ),
  _Course(
    'Civil Engineering',
    'Planning, design and construction of buildings and infrastructure.',
    Icons.apartment_outlined,
    _btech,
  ),
  _Course(
    'Mechanical Engineering',
    'Design, mechanics and manufacturing of machines and systems.',
    Icons.precision_manufacturing_outlined,
    _btech,
  ),
  _Course(
    'Electrical Engineering',
    'Study of electrical power, machines and control systems.',
    Icons.electrical_services_outlined,
    _btech,
  ),
  _Course(
    'Electronics & Communication Engineering',
    'Electronics, communication systems and embedded technologies.',
    Icons.memory_outlined,
    _btech,
  ),
  _Course(
    'Biotechnology',
    'Application of biology and technology to solve real-world problems.',
    Icons.biotech_outlined,
    _btech,
  ),
  _Course(
    'Agricultural Engineering',
    'Engineering principles applied to agriculture and farming systems.',
    Icons.agriculture_outlined,
    _btech,
  ),
];

const List<_Course> _pgCourses = [
  _Course(
    'M.Tech Computer Science',
    'Advanced postgraduate study in computer science.',
    Icons.code,
    _pg,
  ),
  _Course(
    'MBA',
    'Postgraduate programme in management and business administration.',
    Icons.business_center_outlined,
    _pg,
  ),
];

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PageBanner(
            title: 'Academic Programmes',
            subtitle: 'Programmes offered at Bansal Institute of Engineering '
                '& Technology, Lucknow.',
          ),
          PageSection(
            child: Column(
              children: [
                const SectionHeading(title: 'B.Tech Programmes'),
                const SizedBox(height: 32),
                _CourseGrid(courses: _btechCourses),
              ],
            ),
          ),
          PageSection(
            color: AppColors.grey,
            child: Column(
              children: [
                const SectionHeading(title: 'Postgraduate Programmes'),
                const SizedBox(height: 32),
                _CourseGrid(courses: _pgCourses),
              ],
            ),
          ),
          PageSection(
            color: AppColors.lightBlue,
            child: Column(
              children: [
                const Text(
                  'Explore opportunities in engineering, technology and '
                  'management.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () => goTo(context, '/contact'),
                  icon: const Icon(Icons.mail_outline),
                  label: const Text('Contact Us'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseGrid extends StatelessWidget {
  const _CourseGrid({required this.courses});

  final List<_Course> courses;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrap(
      minItemWidth: 300,
      children: [
        for (final _Course course in courses)
          CourseCard(
            icon: course.icon,
            name: course.name,
            description: course.description,
            category: course.category,
          ),
      ],
    );
  }
}
