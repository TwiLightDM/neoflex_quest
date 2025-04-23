import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResultPage extends StatelessWidget {
  final int correctAnswers;

  const ResultPage({super.key, required this.correctAnswers});

  @override
  Widget build(BuildContext context) {
    final int earnedCoins = correctAnswers * 100;

    return Scaffold(
      appBar: AppBar(title: const Text("Результаты")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Вы правильно ответили на $correctAnswers вопрос(ов)!\n",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "Вы заработали $earnedCoins монет!",
              style: const TextStyle(fontSize: 20, color: Colors.orange),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset('lib/assets/animations/fire.json'),
            ),
          ],
        ),
      ),
    );
  }
}
