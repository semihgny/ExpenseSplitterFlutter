import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bottom_nav_bar.dart';

/// Main scaffold shell that wraps all tab screens.
///
/// This widget is used as the builder for [StatefulShellRoute.indexedStack]
/// in the router. It renders the currently active tab's navigation shell
/// and the [BottomNavBar].
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
