import 'package:flutter/material.dart';
import 'pdf_viewer_screen.dart';
import 'notes_data.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chemistry Notes"),
          backgroundColor: const Color(0xFFD50000),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Color(0xFFFFCD00),
            indicatorColor: Color(0xFFFFCD00),
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Semester 1"),
              Tab(text: "Semester 2"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(context, NotesData.sem1Notes),
            _buildList(context, NotesData.sem2Notes),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Map<String, String>> data) {
    if (data.isEmpty) return const Center(child: Text("No notes available yet."));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final note = data[index];

        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFD50000).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.picture_as_pdf, color: Color(0xFFD50000), size: 24),
            ),
            title: Text(
              note['title']!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              note['subtitle']!,
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),

            // Just open the In-App Viewer directly
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfViewerScreen(
                  assetPath: note['file']!,
                  title: note['title']!,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}