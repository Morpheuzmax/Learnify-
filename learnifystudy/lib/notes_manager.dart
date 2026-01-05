class NoteItem {
  String title;
  String description;
  NoteItem({required this.title, required this.description});
}

class NotesManager {
  // Shared List of Notes
  static List<NoteItem> notes = [
    NoteItem(title: "Chapter 1: Matter", description: "Click to download PDF (Demo)"),
    NoteItem(title: "Chapter 2: Atomic Structure", description: "Click to download PDF (Demo)"),
    NoteItem(title: "Chapter 3: Periodic Table", description: "Click to download PDF (Demo)"),
  ];

  static void addNote(NoteItem note) => notes.add(note);
  static void deleteNote(int index) => notes.removeAt(index);
}