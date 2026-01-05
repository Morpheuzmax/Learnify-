
class StudentDatabase {
  // This list stores all students who have logged in/synced
  static final List<Map<String, dynamic>> _students = [];

  static List<Map<String, dynamic>> get allStudents => _students;

  // Called when a student logs in or opens their dashboard
  static void registerOrUpdate(String name, int score) {
    // Check if this student is already in the list
    int index = _students.indexWhere((student) => student['name'] == name);

    if (index != -1) {
      // Update existing score
      _students[index]['score'] = score;
    } else {
      // Add new student
      _students.add({
        "name": name,
        "score": score,
      });
    }

    // Optional: Sort by score (High to Low) for Leaderboard feel
    _students.sort((a, b) => b['score'].compareTo(a['score']));
  }
}