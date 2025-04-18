import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;
  ProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.pink[100],
      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
    );
  }
}