import 'package:flutter/material.dart';
import 'package:neoflex_quest/pages/achievements_page.dart';
import 'package:neoflex_quest/pages/company_info_page.dart';
import 'package:neoflex_quest/pages/programming_tasks_page.dart';
import 'package:neoflex_quest/pages/quiz_page.dart';
import 'package:neoflex_quest/pages/shop_page.dart';
import 'package:neoflex_quest/services/coin_manager.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CoinManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Геймифицированное приложение',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primaryColor: Colors.pink,
        colorScheme: ColorScheme.light(
          primary: Colors.pink,
          secondary: Colors.pinkAccent,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        primaryColor:  Colors.orange,
        colorScheme: ColorScheme.dark(
          primary: Colors.orange,
          secondary: Colors.deepOrange,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        '/quiz': (context) =>  QuizPage(),
        '/tasks': (context) =>  ProgrammingTasksPage(),
        '/shop': (context) =>  ShopPage(),
        '/achievements': (context) =>  AchievementsPage(),
        '/company': (context) =>  CompanyInfoPage(),
      },
    );
  }
}
