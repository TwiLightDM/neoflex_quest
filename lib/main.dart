import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Геймифицированное приложение',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.light(
          primary: Colors.orange,
          secondary: Colors.pink,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.deepOrange,
        colorScheme: ColorScheme.dark(
          primary: Colors.deepOrange,
          secondary: Colors.pinkAccent,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
