import 'package:flutter/material.dart';
import 'dashboard_tab.dart';
import 'quiz_screen.dart';
import 'notes_screen.dart';
import 'tutorial_screen.dart';
import 'past_year_menu.dart';
import 'profile_screen.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int _currentIndex = 0;

  // REMOVED ChatbotScreen from here
  final List<Widget> _pages = [
    const DashboardTab(),        // 0: Home (with Clippy)
    const StudyMenuTab(),        // 1: Study Materials
    const QuizSelectorScreen(),  // 2: Quiz
    const ProfileScreen(),       // 3: Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFD50000).withValues(alpha: 0.2),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Color(0xFFD50000)),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book, color: Color(0xFFD50000)),
            label: 'Study',
          ),
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz, color: Color(0xFFD50000)),
            label: 'Quiz',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: Color(0xFFD50000)),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class StudyMenuTab extends StatelessWidget {
  const StudyMenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Study Materials"),
        backgroundColor: const Color(0xFFD50000),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildLinkCard(context, "Chemistry Notes", Icons.book, const Color(0xFFD50000), const NotesScreen()),
          const SizedBox(height: 12),
          _buildLinkCard(context, "Tutorial Questions", Icons.assignment, const Color(0xFFFFCD00), const TutorialScreen()),
          const SizedBox(height: 12),
          _buildLinkCard(context, "Past Year Papers", Icons.history_edu, Colors.black, const PastYearMenuScreen()),
        ],
      ),
    );
  }

  Widget _buildLinkCard(BuildContext context, String title, IconData icon, Color color, Widget page) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      ),
    );
  }
}