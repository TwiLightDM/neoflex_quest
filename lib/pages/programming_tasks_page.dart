import 'package:flutter/material.dart';

class ProgrammingTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Программистские задачи")),
      body: Center(child: Text("Решите задачу на программирование!", style: TextStyle(fontSize: 20))),
    );
  }
}