import 'package:flutter/material.dart';

import 'footer.dart';
import 'navbar.dart';

/// Shared page frame: navigation bar, scrollable body and footer.
/// Every page is wrapped in this so the layout stays consistent.
class PageLayout extends StatelessWidget {
  const PageLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            child,
            const Footer(),
          ],
        ),
      ),
    );
  }
}
