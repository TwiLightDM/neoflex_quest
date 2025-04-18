import 'package:flutter/material.dart';

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ролики")),
      body: Center(child: Text("Здесь будут видео о сотрудниках.", style: TextStyle(fontSize: 20))),
    );
  }
}