  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'dart:convert';
  import 'package:lottie/lottie.dart';
import 'package:neoflex_quest/pages/result_page.dart';

  import '../services/coin_manager.dart';

  class QuizPage extends StatefulWidget {
    const QuizPage({super.key});

    @override
    State<QuizPage> createState() => _QuizPageState();
  }

  class _QuizPageState extends State<QuizPage> {
    List<dynamic> _questions = [];
    int _currentIndex = 0;
    int _correctAnswers = 0;
    bool _isAnswered = false;
    int? _selectedOption;
    bool _showAnswer = false;

    @override
    void initState() {
      super.initState();
      _loadQuestions();
    }

    Future<void> _loadQuestions() async {
      try {
        final String response = await rootBundle.loadString('lib/assets/data/quest.json');
        final data = json.decode(response);
        setState(() {
          _questions = data;
        });
      } catch (e) {
        debugPrint("Ошибка загрузки данных: $e");
      }
    }

    void _handleAnswer(int index) {
      if (_isAnswered) return;

      final current = _questions[_currentIndex];
      bool isCorrect = current['options'][index] == current['answer'];

      setState(() {
        _isAnswered = true;
        _selectedOption = index;
        if (isCorrect) {
          _correctAnswers++;
          CoinManager.addCoins(100);
        };
      });

      Future.delayed(const Duration(milliseconds: 800), () {
        if (_currentIndex + 1 < _questions.length) {
          setState(() {
            _currentIndex++;
            _selectedOption = null;
            _isAnswered = false;
            _showAnswer = false;
          });
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ResultPage(correctAnswers: _correctAnswers),
            ),
          );
        }
      });
    }

    void _revealAnswer() {
      setState(() {
        _showAnswer = true;
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
        appBar: AppBar(title: const Text("Квиз от неончика")),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                child: Column(
                  children: [
                    Text(
                      current['question'],
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ...List.generate(current['options'].length, (index) {
                      final isSelected = _selectedOption == index;
                      final isCorrect = current['options'][index] == current['answer'];
                      final isDark = Theme.of(context).brightness == Brightness.dark;

                      Color bgColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;

                      if (isSelected) {
                        bgColor = isCorrect ? Colors.green : Colors.red;
                      }

                      return GestureDetector(
                        onTap: () => _handleAnswer(index),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              current['options'][index],
                              style: TextStyle(
                                fontSize: 18,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _revealAnswer,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Lottie.asset('lib/assets/animations/neonchik.json'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 180,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _showAnswer
                          ? "Ответ: ${current['answer']}"
                          : "Neoflex всегда поможет",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
