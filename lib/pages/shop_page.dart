import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Магазин")),
      body: Center(child: Text("Добро пожаловать в магазин!", style: TextStyle(fontSize: 20))),
    );
  }
}