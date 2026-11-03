import 'package:flutter/material.dart';

import 'pages/about_page.dart';
import 'pages/contact_page.dart';
import 'pages/courses_page.dart';
import 'pages/home_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const BietApp());
}

class BietApp extends StatelessWidget {
  const BietApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BIET Lucknow - Student Project',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      onGenerateRoute: _generateRoute,
    );
  }

  /// Maps route names to the four pages of the website.
  Route<dynamic> _generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case '/about':
        page = const AboutPage();
        break;
      case '/courses':
        page = const CoursesPage();
        break;
      case '/contact':
        page = const ContactPage();
        break;
      case '/':
      default:
        page = const HomePage();
    }

    // No transition animation: keeps the site simple and fast.
    return PageRouteBuilder<void>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}
