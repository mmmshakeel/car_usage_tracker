import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/log/log_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/tracker/tracker_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const TrackerScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/log',
      builder: (context, state) => const LogScreen(),
    ),
  ],
);

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return Scaffold(
      body: child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: BottomNavigationBar(
              currentIndex: _tabIndex(location),
              onTap: (index) => _onTap(context, index),
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              iconSize: 24,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.directions_car_outlined),
                  activeIcon: Icon(Icons.directions_car),
                  label: 'Drive Tracker',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings),
                  label: 'Contract',
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
                Theme.of(context).colorScheme.surface,
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }

  int _tabIndex(String location) {
    if (location.startsWith('/settings')) return 1;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
      case 1:
        context.go('/settings');
    }
  }
}
