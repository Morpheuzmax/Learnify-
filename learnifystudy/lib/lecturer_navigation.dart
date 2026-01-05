import 'package:flutter/material.dart';
import 'lecturer_home_tab.dart';
import 'manage_notes_screen.dart';
import 'manage_quiz_screen.dart';
import 'lecturer_profile_screen.dart';

class LecturerNavigation extends StatefulWidget {
  const LecturerNavigation({super.key});

  @override
  State<LecturerNavigation> createState() => _LecturerNavigationState();
}

class _LecturerNavigationState extends State<LecturerNavigation> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const LecturerHomeTab(),
    const ManageNotesScreen(),
    const ManageQuizScreen(),
    const LecturerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFD50000).withValues(alpha: 0.2),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard, color: Color(0xFFD50000)), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.upload_file_outlined), selectedIcon: Icon(Icons.upload_file, color: Color(0xFFD50000)), label: 'Materials'),
          NavigationDestination(icon: Icon(Icons.edit_note_outlined), selectedIcon: Icon(Icons.edit_note, color: Color(0xFFD50000)), label: 'Quiz'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: Color(0xFFD50000)), label: 'Profile'),
        ],
      ),
    );
  }
}