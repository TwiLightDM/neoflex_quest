import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Уведомления")),
      body: Center(child: Text("Все ваши уведомления здесь.", style: TextStyle(fontSize: 20))),
    );
  }
}