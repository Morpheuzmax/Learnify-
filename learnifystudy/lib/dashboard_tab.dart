import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'score_manager.dart';
import 'student_database.dart';
import 'exam_schedule.dart';
import 'chatbot_screen.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final String displayName = user?.displayName ?? "Student";
    int myPercentage = ScoreManager.getOverallPercentage();
    StudentDatabase.registerOrUpdate(displayName, myPercentage);
    List<Map<String, dynamic>> leaderboard = StudentDatabase.allStudents;

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
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xFFFFCD00),
                          child: Text(
                            displayName.isNotEmpty ? displayName[0].toUpperCase() : "S",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, $displayName!",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Stay focused on your goals!",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatColumn(
                              label: "Rank",
                              value: "#${leaderboard.indexWhere((s) => s['name'] == displayName) + 1}"),
                          _StatColumn(
                              label: "Score", value: "$myPercentage%"),
                          const _StatColumn(label: "Badges", value: "3"),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: -15,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatbotScreen()),
                      );
                    },
                    child: Container(
                      width: 85,
                      height: 85,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD50000),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/clippy3.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                _buildCountdownCard(
                    "PSPM 1", daysToPSPM1, const Color(0xFFFFCD00)),
                const SizedBox(width: 12),
                _buildCountdownCard(
                    "PSPM 2", daysToPSPM2, const Color(0xFFD50000)),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text("🏆 Class Leaderboard",
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ),
          Expanded(
            child: leaderboard.isEmpty
                ? const Center(child: Text("No students yet."))
                : ListView.builder(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: leaderboard.length,
              itemBuilder: (context, index) {
                final student = leaderboard[index];
                return _buildRankItem(
                    index + 1,
                    student['name'],
                    student['score'],
                    student['name'] == displayName);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownCard(String title, int days, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
                color: color.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(days > 0 ? "$days Days" : "Exam Day!",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            const Text("Left", style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildRankItem(int rank, String name, int score, bool isMe) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isMe
            ? const Color(0xFFD50000).withValues(alpha: 0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isMe
            ? Border.all(color: const Color(0xFFD50000), width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Text("#$rank",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(width: 16),
          Expanded(
              child: Text(name,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          if (score >= 80)
            const Icon(Icons.verified, color: Color(0xFFFFCD00), size: 20),
          const SizedBox(width: 5),
          Text("$score%",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFFD50000))),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  const _StatColumn({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(value,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      Text(label,
          style: const TextStyle(color: Colors.white70, fontSize: 12))
    ]);
  }
}