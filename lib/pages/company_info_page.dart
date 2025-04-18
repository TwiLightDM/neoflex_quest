import 'package:flutter/material.dart';

class CompanyInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Информация о компании")),
      body: Center(child: Text("Вакансии, расположение и многое другое.", style: TextStyle(fontSize: 20))),
    );
  }
}