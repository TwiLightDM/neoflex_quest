import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ProgrammingTasksPage extends StatefulWidget {
  const ProgrammingTasksPage({super.key});

  @override
  State<ProgrammingTasksPage> createState() => _ProgrammingTasksPageState();
}

class _ProgrammingTasksPageState extends State<ProgrammingTasksPage> {
  List<dynamic> _questions = [];
  int _currentIndex = 0;
  bool _isAnswered = false;
  int? _selectedOption;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final String response =
    await rootBundle.loadString('lib/assets/data/programming_tasks.json');
    final data = await json.decode(response);
    setState(() {
      _questions = data;
    });
  }

  void _handleAnswer(int index) {
    if (_isAnswered) return;

    final current = _questions[_currentIndex];
    bool isCorrect = current['options'][index] == current['answer'];

    setState(() {
      _selectedOption = index;
      _isCorrect = isCorrect;
      _isAnswered = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (isCorrect) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _questions.length;
          _isAnswered = false;
          _selectedOption = null;
        });
      } else {
        setState(() {
          _isAnswered = false;
          _selectedOption = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final current = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text("Программистские задачи")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              current['question'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.builder(
                itemCount: current['options'].length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.8,
                ),
                itemBuilder: (context, index) {
                  final isSelected = _selectedOption == index;
                  Color bgColor = Colors.grey[300]!;

                  if (isSelected) {
                    bgColor = _isCorrect ? Colors.green : Colors.red;
                  }

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () => _handleAnswer(index),
                      child: Center(
                        child: Text(
                          current['options'][index],
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
