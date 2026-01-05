import 'package:flutter/material.dart';
import 'notes_data.dart';
import 'pdf_viewer_screen.dart';

class ManageNotesScreen extends StatefulWidget {
  const ManageNotesScreen({super.key});

  @override
  State<ManageNotesScreen> createState() => _ManageNotesScreenState();
}

class _ManageNotesScreenState extends State<ManageNotesScreen> {
  int _selectedSem = 0;
  String _selectedChapter = "Chapter 1";
  final List<String> _sem1Chapters = ["Chapter 1", "Chapter 2", "Chapter 3", "Chapter 4", "Chapter 5", "Chapter 9"];
  final List<String> _sem2Chapters = ["Chapter 1", "Chapter 2", "Chapter 3", "Chapter 4"];

  void _showUploadDialog() {
    final fileNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Upload to $_selectedChapter"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_upload_outlined, size: 50, color: Color(0xFFD50000)),
            const SizedBox(height: 20),
            TextField(controller: fileNameController, decoration: const InputDecoration(labelText: "Note Title", border: OutlineInputBorder())),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (fileNameController.text.isNotEmpty) {
                setState(() => NotesData.addNote(_selectedSem, _selectedChapter, fileNameController.text));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uploaded to $_selectedChapter!"), backgroundColor: const Color(0xFFFFCD00)));
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD50000), foregroundColor: Colors.white),
            child: const Text("Upload"),
          ),
        ],
      ),
    );
  }

  void _deleteNote(Map<String, String> note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Note?"),
        content: Text("Remove '${note['subtitle']}'?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              setState(() => NotesData.deleteNote(_selectedSem, note));
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Color(0xFFD50000))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> fullList = _selectedSem == 0 ? NotesData.sem1Notes : NotesData.sem2Notes;
    List<Map<String, String>> filteredList = fullList.where((note) => note['title'] == _selectedChapter).toList();
    List<String> currentChapterButtons = _selectedSem == 0 ? _sem1Chapters : _sem2Chapters;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Manage Materials"), backgroundColor: const Color(0xFFD50000), foregroundColor: Colors.white),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: Row(children: [_buildSemButton("Semester 1", 0), const SizedBox(width: 12), _buildSemButton("Semester 2", 1)])),
          const SizedBox(height: 20),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: currentChapterButtons.length,
              itemBuilder: (context, index) => Padding(padding: const EdgeInsets.only(right: 8.0), child: _buildChapterButton(currentChapterButtons[index])),
            ),
          ),
          const Divider(thickness: 1, height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Content in $_selectedChapter", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFD50000), fontSize: 16)),
          ),
          Expanded(
            child: filteredList.isEmpty
                ? const Center(child: Text("No notes here yet.", style: TextStyle(color: Colors.grey)))
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final note = filteredList[index];
                return Card(
                  elevation: 2, margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFFD50000).withValues(alpha: 0.1), shape: BoxShape.circle), child: const Icon(Icons.picture_as_pdf, color: Color(0xFFD50000))),
                    title: Text(note['subtitle'] ?? "Unknown", style: const TextStyle(fontWeight: FontWeight.bold)),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewerScreen(assetPath: note['file']!, title: note['subtitle']!))),
                    trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.grey), onPressed: () => _deleteNote(note)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showUploadDialog,
        backgroundColor: const Color(0xFFD50000),
        icon: const Icon(Icons.upload, color: Colors.white),
        label: const Text("Upload Note", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildSemButton(String text, int index) {
    bool isSelected = _selectedSem == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() { _selectedSem = index; _selectedChapter = "Chapter 1"; }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: isSelected ? const Color(0xFFD50000) : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFD50000))),
          alignment: Alignment.center,
          child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.white : const Color(0xFFD50000))),
        ),
      ),
    );
  }

  Widget _buildChapterButton(String chapterName) {
    bool isSelected = _selectedChapter == chapterName;
    return ChoiceChip(
      label: Text(chapterName),
      selected: isSelected,
      onSelected: (bool selected) { if (selected) setState(() => _selectedChapter = chapterName); },
      selectedColor: const Color(0xFFFFCD00),
      labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.black),
      backgroundColor: Colors.white,
      side: isSelected ? const BorderSide(color: Colors.transparent) : BorderSide(color: Colors.grey.shade300),
    );
  }
}