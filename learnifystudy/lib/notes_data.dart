class NotesData {
  // 🟢 SHARED LIST FOR SEMESTER 1
  static List<Map<String, String>> sem1Notes = [
    {
      "title": "Chapter 1",
      "subtitle": "Matter",
      "file": "assets/notes/chapter1.pdf"
    },
    {
      "title": "Chapter 2",
      "subtitle": "Atomic Structure",
      "file": "assets/notes/chapter2.pdf"
    },
    {
      "title": "Chapter 3",
      "subtitle": "Periodic Table",
      "file": "assets/notes/chapter3.pdf"
    },
    {
      "title": "Chapter 4",
      "subtitle": "Chemical Bonding",
      "file": "assets/notes/chapter4.pdf"
    },
    {
      "title": "Chapter 5",
      "subtitle": "States of Matter",
      "file": "assets/notes/chapter5.pdf"
    },
    {
      "title": "Chapter 9",
      "subtitle": "Thermochemistry",
      "file": "assets/notes/chapter9.pdf"
    },
  ];

  // 🔵 SHARED LIST FOR SEMESTER 2
  static List<Map<String, String>> sem2Notes = [
    {
      "title": "Chapter 1",
      "subtitle": "Reaction Kinetics",
      "file": "assets/notes/chapter1_2.pdf"
    },
    {
      "title": "Chapter 2",
      "subtitle": "Thermochemistry",
      "file": "assets/notes/chapter2_2.pdf"
    },
    {
      "title": "Chapter 3",
      "subtitle": "Electrochemistry",
      "file": "assets/notes/chapter3_2.pdf"
    },
    {
      "title": "Chapter 4",
      "subtitle": "Intro to Organic Chemistry",
      "file": "assets/notes/chapter4_2.pdf"
    },
    {
      "title": "Chapter 5",
      "subtitle": "Hydrocarbons",
      "file": "assets/notes/chapter5_2.pdf"
    },
    {
      "title": "Chapter 6",
      "subtitle": "Benzene & Its Derivatives",
      "file": "assets/notes/chapter6_2.pdf"
    },
    {
      "title": "Chapter 7",
      "subtitle": "Haloalkanes",
      "file": "assets/notes/chapter7_2.pdf"
    },
  ];

  // FUNCTION: Add a new note
  static void addNote(int semIndex, String chapterTitle, String noteSubtitle) {
    Map<String, String> newNote = {
      "title": chapterTitle,
      "subtitle": noteSubtitle,
      "file": "assets/notes/chapter1.pdf"
    };

    if (semIndex == 0) {
      sem1Notes.add(newNote);
    } else {
      sem2Notes.add(newNote);
    }
  }

  // FUNCTION: Delete a note
  static void deleteNote(int semIndex, Map<String, String> noteToDelete) {
    if (semIndex == 0) {
      sem1Notes.remove(noteToDelete);
    } else {
      sem2Notes.remove(noteToDelete);
    }
  }
}