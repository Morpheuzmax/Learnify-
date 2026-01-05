import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'student_database.dart';
import 'exam_schedule.dart';

class LecturerHomeTab extends StatefulWidget {
  const LecturerHomeTab({super.key});

  @override
  State<LecturerHomeTab> createState() => _LecturerHomeTabState();
}

class _LecturerHomeTabState extends State<LecturerHomeTab> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final String displayName = user?.displayName ?? "Lecturer";
    List<Map<String, dynamic>> students = StudentDatabase.allStudents;
    final now = DateTime.now();
    int daysToPSPM1 = ExamSchedule.pspm1Date.difference(now).inDays;
    int daysToPSPM2 = ExamSchedule.pspm2Date.difference(now).inDays;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
            decoration: const BoxDecoration(
              color: Color(0xFFD50000),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30, backgroundColor: const Color(0xFFFFCD00),
                  child: Text(displayName[0].toUpperCase(), style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello, $displayName!", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    Text("${students.length} Students Active", style: const TextStyle(color: Colors.white70)),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                _buildCountdownCard("PSPM 1 Countdown", daysToPSPM1),
                const SizedBox(width: 12),
                _buildCountdownCard("PSPM 2 Countdown", daysToPSPM2),
              ],
            ),
          ),
          Expanded(
            child: students.isEmpty
                ? const Center(child: Text("No students yet."))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return _buildStudentCard(name: student['name'], score: student['score']);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownCard(String title, int days) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFD50000), fontSize: 12)),
            const SizedBox(height: 5),
            Text(days > 0 ? "$days Days" : "Today!", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentCard({required String name, required int score}) {
    Color scoreColor = score >= 50 ? Colors.white : Colors.red;
    return Card(
      elevation: 2, margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(backgroundColor: Color(0xFFFFCD00), child: Icon(Icons.person, color: Colors.black)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (score >= 80) const Icon(Icons.verified, color: Color(0xFFD50000)),
            const SizedBox(width: 8),
            Text("$score%", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: scoreColor)),
          ],
        ),
      ),
    );
  }
}