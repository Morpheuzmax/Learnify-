import 'package:flutter/material.dart';
import 'quiz_data.dart';

class ManageQuizScreen extends StatefulWidget {
  const ManageQuizScreen({super.key});

  @override
  State<ManageQuizScreen> createState() => _ManageQuizScreenState();
}

class _ManageQuizScreenState extends State<ManageQuizScreen> {
  int _selectedSem = 0;
  int _selectedChapIndex = 0;
  final List<String> _sem1Chapters = ["1. Matter", "2. Atomic Structure", "3. Periodic Table", "4. Chemical Bonding", "5. States of Matter", "6. Chemical Equilibrium"];
  final List<String> _sem2Chapters = ["1. Reaction Kinetics", "2. Thermochemistry", "3. Electrochemistry", "4. Intro to Organic Chem", "5. Hydrocarbons", "6. Haloalkanes", "7. Hydroxy Compounds"];

  void _deleteQuestion(int index) {
    setState(() => QuizData.deleteQuestion(_selectedSem, _selectedChapIndex, index));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Question Deleted")));
  }

  void _showQuestionDialog({int? index}) {
    bool isEditing = index != null;
    Question? existingQ = isEditing ? QuizData.getQuestions(_selectedSem, _selectedChapIndex)[index] : null;
    final textController = TextEditingController(text: existingQ?.questionText ?? "");
    final opt1Controller = TextEditingController(text: existingQ?.options[0] ?? "");
    final opt2Controller = TextEditingController(text: existingQ?.options[1] ?? "");
    final opt3Controller = TextEditingController(text: existingQ?.options[2] ?? "");
    final opt4Controller = TextEditingController(text: existingQ?.options[3] ?? "");
    int correctIdx = existingQ?.correctIndex ?? 0;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(isEditing ? "Edit Question" : "Add Question"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: textController, decoration: const InputDecoration(labelText: "Question Text")),
                  TextField(controller: opt1Controller, decoration: const InputDecoration(labelText: "Option A")),
                  TextField(controller: opt2Controller, decoration: const InputDecoration(labelText: "Option B")),
                  TextField(controller: opt3Controller, decoration: const InputDecoration(labelText: "Option C")),
                  TextField(controller: opt4Controller, decoration: const InputDecoration(labelText: "Option D")),
                  DropdownButton<int>(
                    value: correctIdx, isExpanded: true,
                    items: const [DropdownMenuItem(value: 0, child: Text("Correct Answer: Option A")), DropdownMenuItem(value: 1, child: Text("Correct Answer: Option B")), DropdownMenuItem(value: 2, child: Text("Correct Answer: Option C")), DropdownMenuItem(value: 3, child: Text("Correct Answer: Option D"))],
                    onChanged: (val) => setDialogState(() => correctIdx = val!),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
              ElevatedButton(
                onPressed: () {
                  final newQ = Question(questionText: textController.text, options: [opt1Controller.text, opt2Controller.text, opt3Controller.text, opt4Controller.text], correctIndex: correctIdx);

                  // FIXED: Added curly braces { } for if and else blocks
                  setState(() {
                    if (isEditing) {
                      QuizData.editQuestion(_selectedSem, _selectedChapIndex, index, newQ);
                    } else {
                      QuizData.addQuestion(_selectedSem, _selectedChapIndex, newQ);
                    }
                  });

                  Navigator.pop(context);
                },
                child: const Text("Save"),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentChapterNames = _selectedSem == 0 ? _sem1Chapters : _sem2Chapters;
    if (_selectedChapIndex >= currentChapterNames.length) _selectedChapIndex = 0;
    List<Question> questions = QuizData.getQuestions(_selectedSem, _selectedChapIndex);

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Quizzes"), backgroundColor: const Color(0xFFD50000), foregroundColor: Colors.white),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                Row(children: [_buildSemButton("Semester 1", 0), const SizedBox(width: 10), _buildSemButton("Semester 2", 1)]),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFD50000))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _selectedChapIndex, isExpanded: true,
                      items: List.generate(currentChapterNames.length, (index) => DropdownMenuItem(value: index, child: Text(currentChapterNames[index]))),
                      onChanged: (val) => setState(() => _selectedChapIndex = val!),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: questions.isEmpty
                ? const Center(child: Text("No questions yet.", textAlign: TextAlign.center))
                : ListView.builder(
              itemCount: questions.length, padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final q = questions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text("Q${index + 1}: ${q.questionText}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Ans: ${q.options[q.correctIndex]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _showQuestionDialog(index: index)),
                        IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteQuestion(index)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => _showQuestionDialog(), backgroundColor: const Color(0xFFD50000), child: const Icon(Icons.add, color: Colors.white)),
    );
  }

  Widget _buildSemButton(String text, int index) {
    bool isSelected = _selectedSem == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedSem = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: isSelected ? const Color(0xFFD50000) : Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFD50000))),
          alignment: Alignment.center,
          child: Text(text, style: TextStyle(color: isSelected ? Colors.white : const Color(0xFFD50000), fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}