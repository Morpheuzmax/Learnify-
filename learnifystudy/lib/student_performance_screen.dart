import 'package:flutter/material.dart';
import 'student_database.dart';

class StudentPerformanceScreen extends StatelessWidget {
  const StudentPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> students = StudentDatabase.allStudents;

    return Scaffold(
      appBar: AppBar(title: const Text("Student Performance"), backgroundColor: Colors.blue[900], foregroundColor: Colors.white),
      body: students.isEmpty
          ? const Center(child: Text("No data available yet."))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return _buildStudentCard(student['name'], student['score']);
        },
      ),
    );
  }

  Widget _buildStudentCard(String name, int score) {
    Color scoreColor = score >= 50 ? Colors.green : Colors.red;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: scoreColor.withValues(alpha: 0.1),
          child: const Icon(Icons.person, color: Colors.black54),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),

        // --- BADGE & SCORE ---
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (score >= 80)
              const Icon(Icons.verified, color: Colors.amber), // Gold Badge

            const SizedBox(width: 8),

            Text("$score%", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: scoreColor)),
          ],
        ),
      ),
    );
  }
}