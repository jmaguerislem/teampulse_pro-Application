import 'package:flutter/material.dart';

import '../widgets/app_bottom_nav.dart';
import 'dashboard_screen.dart';
import 'more_screen.dart';
import 'projects_screen.dart';
import 'tasks_screen.dart';
import 'team_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final _pages = const [
    DashboardScreen(),
    ProjectsScreen(),
    TasksScreen(),
    TeamScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
