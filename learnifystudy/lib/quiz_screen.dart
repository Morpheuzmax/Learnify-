import 'package:flutter/material.dart';
import 'quiz_taking_screen.dart';
import 'score_manager.dart';
import 'quiz_data.dart';

class QuizSelectorScreen extends StatefulWidget {
  const QuizSelectorScreen({super.key});

  @override
  State<QuizSelectorScreen> createState() => _QuizSelectorScreenState();
}

class _QuizSelectorScreenState extends State<QuizSelectorScreen> {
  int _selectedSem = 0;
  final List<String> _sem1Chapters = ["1. Matter", "2. Atomic Structure", "3. Periodic Table", "4. Chemical Bonding", "5. States of Matter", "6. Chemical Equilibrium"];
  final List<String> _sem2Chapters = ["1. Reaction Kinetics", "2. Thermochemistry", "3. Electrochemistry", "4. Intro to Organic Chem", "5. Hydrocarbons", "6. Haloalkanes", "7. Hydroxy Compounds"];

  @override
  Widget build(BuildContext context) {
    List<String> currentChapters = _selectedSem == 0 ? _sem1Chapters : _sem2Chapters;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Quiz Zone"), backgroundColor: const Color(0xFFD50000), foregroundColor: Colors.white, elevation: 0, automaticallyImplyLeading: false),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
            child: Row(children: [_buildSemButton("Semester 1", 0), _buildSemButton("Semester 2", 1)]),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: currentChapters.length,
              itemBuilder: (context, index) {
                int score = ScoreManager.getScore(_selectedSem, index);
                int questionCount = QuizData.getQuestions(_selectedSem, index).length;
                bool hasTaken = score != -1;
                return Card(
                  elevation: 3, margin: const EdgeInsets.only(bottom: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    leading: Container(
                      width: 45, height: 45,
                      decoration: BoxDecoration(color: const Color(0xFFD50000).withValues(alpha: 0.1), shape: BoxShape.circle),
                      child: Center(child: Text("${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFD50000), fontSize: 18))),
                    ),
                    title: Text(currentChapters[index], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text("$questionCount Questions", style: const TextStyle(fontSize: 12)),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QuizTakingScreen(semIndex: _selectedSem, chapterIndex: index, chapterName: currentChapters[index]))).then((_) => setState(() {})),
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD50000), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                            child: const Text("Start"),
                          ),
                        ),
                        if (hasTaken) Padding(padding: const EdgeInsets.only(top: 4.0), child: Text("Score: $score/$questionCount", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green))),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSemButton(String text, int index) {
    bool isSelected = _selectedSem == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedSem = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: isSelected ? const Color(0xFFD50000) : Colors.transparent, borderRadius: BorderRadius.circular(25)),
          alignment: Alignment.center,
          child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.grey[700])),
        ),
      ),
    );
  }
}