import 'package:flutter/material.dart';

class AchievementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ачивки")),
      body: Center(child: Text("Здесь будут ваши ачивки!", style: TextStyle(fontSize: 20))),
    );
  }
}