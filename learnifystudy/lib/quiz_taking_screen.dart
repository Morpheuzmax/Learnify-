import 'package:flutter/material.dart';
import 'quiz_data.dart';
import 'score_manager.dart';

class QuizTakingScreen extends StatefulWidget {
  final int semIndex;
  final int chapterIndex;
  final String chapterName;
  const QuizTakingScreen({super.key, required this.semIndex, required this.chapterIndex, required this.chapterName});

  @override
  State<QuizTakingScreen> createState() => _QuizTakingScreenState();
}

class _QuizTakingScreenState extends State<QuizTakingScreen> {
  late List<Question> _questions;
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    _questions = QuizData.getQuestions(widget.semIndex, widget.chapterIndex);
  }

  void _submitAnswer() {
    if (_selectedOptionIndex == null) return;
    if (_selectedOptionIndex == _questions[_currentQuestionIndex].correctIndex) _score++;
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() { _currentQuestionIndex++; _selectedOptionIndex = null; });
    } else {
      ScoreManager.saveScore(widget.semIndex, widget.chapterIndex, _score);
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    double percentage = _questions.isEmpty ? 0 : (_score / _questions.length) * 100;
    showDialog(
      context: context, barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Quiz Completed! 🏆"),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Score: $_score / ${_questions.length}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("${percentage.toStringAsFixed(0)}%", style: TextStyle(fontSize: 30, color: percentage >= 50 ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
        ]),
        actions: [TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text("Back to Menu"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) return Scaffold(appBar: AppBar(title: const Text("Quiz"), backgroundColor: const Color(0xFFD50000), foregroundColor: Colors.white), body: const Center(child: Text("No questions set for this chapter.")));
    final question = _questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: Text("Q${_currentQuestionIndex + 1}/${_questions.length}"), backgroundColor: const Color(0xFFD50000), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(value: (_currentQuestionIndex + 1) / _questions.length, backgroundColor: Colors.grey[300], color: const Color(0xFFD50000)),
            const SizedBox(height: 30),
            Text(question.questionText, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedOptionIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedOptionIndex = index),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: isSelected ? const Color(0xFFD50000).withValues(alpha: 0.1) : Colors.white, border: Border.all(color: isSelected ? const Color(0xFFD50000) : Colors.grey.shade300, width: 2), borderRadius: BorderRadius.circular(12)),
                      child: Row(children: [Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: isSelected ? const Color(0xFFD50000) : Colors.grey), const SizedBox(width: 12), Expanded(child: Text(question.options[index], style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? const Color(0xFFD50000) : Colors.black87)))]),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 50, child: ElevatedButton(onPressed: _selectedOptionIndex == null ? null : _submitAnswer, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD50000), foregroundColor: Colors.white, disabledBackgroundColor: Colors.grey[300]), child: Text(_currentQuestionIndex == _questions.length - 1 ? "Submit Quiz" : "Next Question", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
          ],
        ),
      ),
    );
  }
}