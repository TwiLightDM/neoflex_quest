import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Квиз")),
      body: Center(child: Text("Квиз для пользователя!", style: TextStyle(fontSize: 20))),
    );
  }
}
