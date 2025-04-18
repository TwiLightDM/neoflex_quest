import 'package:flutter/material.dart';

class DailyTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Дейлики")),
      body: Center(child: Text("Выполни дейлик сегодня!", style: TextStyle(fontSize: 20))),
    );
  }
}
