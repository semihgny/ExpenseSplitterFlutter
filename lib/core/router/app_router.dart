import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/groups/screens/group_detail_screen.dart';
import '../../features/groups/screens/personal_screen.dart';
import '../../features/groups/screens/result_screen.dart';
import '../../features/logs/screens/logs_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../shared/widgets/app_scaffold.dart';

/// Navigator keys for each tab branch so GoRouter can manage nested
/// navigation stacks independently.
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _personalNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'personal');
final _sharedNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shared');
final _logsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'logs');
final _settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

/// Riverpod provider that exposes the app's [GoRouter] instance.
///
/// Usage:
/// ```dart
/// final router = ref.watch(goRouterProvider);
/// ```
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      // ── Tabbed shell ─────────────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Tab 0 – Kişisel (Personal)
          StatefulShellBranch(
            navigatorKey: _personalNavigatorKey,
            routes: [
              GoRoute(
                path: '/personal',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PersonalScreen(),
                ),
                routes: [
                  // Nested: /personal/group/:id
                  GoRoute(
                    path: 'group/:id',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final groupId = state.pathParameters['id']!;
                      return GroupDetailScreen(groupId: groupId);
                    },
                    routes: [
                      // Nested: /personal/group/:id/result
                      GoRoute(
                        path: 'result',
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) {
                          final groupId = state.pathParameters['id']!;
                          return ResultScreen(groupId: groupId);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Tab 1 – Kayıtlar (Logs)
          StatefulShellBranch(
            navigatorKey: _logsNavigatorKey,
            routes: [
              GoRoute(
                path: '/logs',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: LogsScreen(),
                ),
              ),
            ],
          ),

          // Tab 3 – Ayarlar (Settings)
          StatefulShellBranch(
            navigatorKey: _settingsNavigatorKey,
            routes: [
              GoRoute(
                path: '/settings',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SettingsScreen(),
                ),
              ),
            ],
          ),
        ],
      ),

      // ── Top-level redirects ──────────────────────────────────
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/',
        redirect: (context, state) => '/splash',
      ),
    ],
  );
});
