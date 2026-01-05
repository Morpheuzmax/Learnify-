import 'package:flutter/material.dart';
import 'pdf_viewer_screen.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});
  final List<Map<String, String>> sem1Tutorials = const [{'title': 'Tutorial Chapter 1', 'file': 'tuto_chapter1.pdf'}, {'title': 'Tutorial Chapter 2', 'file': 'tuto_chapter2.pdf'}, {'title': 'Tutorial Chapter 3', 'file': 'tuto_chapter3.pdf'}, {'title': 'Tutorial Chapter 4', 'file': 'tuto_chapter4.pdf'}, {'title': 'Tutorial Chapter 5', 'file': 'tuto_chapter5.pdf'}];
  final List<Map<String, String>> sem2Tutorials = const [{'title': 'Tutorial Chapter 1', 'file': 'tuto_chapter1_2.pdf'}, {'title': 'Tutorial Chapter 2', 'file': 'tuto_chapter2_2.pdf'}, {'title': 'Tutorial Chapter 3', 'file': 'tuto_chapter3_2.pdf'}, {'title': 'Tutorial Chapter 4', 'file': 'tuto_chapter4_2.pdf'}];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text("Tutorial Questions"), backgroundColor: const Color(0xFFD50000), foregroundColor: Colors.white, bottom: const TabBar(labelColor: Color(0xFFFFCD00), indicatorColor: Color(0xFFFFCD00), unselectedLabelColor: Colors.white70, tabs: [Tab(text: "Semester 1"), Tab(text: "Semester 2")])),
        body: TabBarView(children: [_buildList(context, sem1Tutorials), _buildList(context, sem2Tutorials)]),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Map<String, String>> data) {
    if (data.isEmpty) return const Center(child: Text("No tutorials available yet."));
    return ListView.builder(
      padding: const EdgeInsets.all(16), itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2, margin: const EdgeInsets.only(bottom: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFD50000).withValues(alpha: 0.1), shape: BoxShape.circle), child: const Icon(Icons.assignment, color: Color(0xFFD50000), size: 24)),
            title: Text(data[index]['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewerScreen(assetPath: "assets/tutorial/${data[index]['file']!}", title: data[index]['title']!))),
          ),
        );
      },
    );
  }
}