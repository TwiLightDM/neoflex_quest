import 'package:flutter/material.dart';
import 'package:neoflex_quest/pages/programming_tasks_page.dart';
import 'package:neoflex_quest/pages/quiz_page.dart';
import 'package:neoflex_quest/pages/shop_page.dart';
import 'package:neoflex_quest/pages/achievements_page.dart';
import 'package:neoflex_quest/pages/company_info_page.dart';
import 'package:neoflex_quest/pages/daily_tasks_page.dart';
import 'package:neoflex_quest/services/coin_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Главная',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      routes: {
        '/achievements': (_) => AchievementsPage(),
        '/daily': (_) => DailyTasksPage(),
        '/shop': (_) => ShopPage(),
        '/tasks': (_) => ProgrammingTasksPage(),
        '/company': (_) => CompanyInfoPage(),
        '/quiz': (_) => QuizPage(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _coins = 0;

  @override
  void initState() {
    super.initState();
    _loadCoins();
  }

  Future<void> _loadCoins() async {
    await CoinManager.init();
    final coins = await CoinManager.getCoins();
    setState(() {
      _coins = coins;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Главная',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      ValueListenableBuilder<int>(
                        valueListenable: CoinManager.coins,
                        builder: (context, coins, _) {
                          return Text('$coins монет', style: const TextStyle(fontSize: 16));
                        },
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.emoji_events_outlined),
                        iconSize: 32,
                        onPressed: () {
                          Navigator.pushNamed(context, '/achievements');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Center(child: CircularProgressIndicator(value: 0.6)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/quiz'),
              child: const Text('Начать квиз'),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _HomeIconButton(
                    icon: Icons.today,
                    label: 'Дейлики',
                    onTap: () => Navigator.pushNamed(context, '/daily'),
                  ),
                  _HomeIconButton(
                    icon: Icons.store,
                    label: 'Магазин',
                    onTap: () => Navigator.pushNamed(context, '/shop'),
                  ),
                  _HomeIconButton(
                    icon: Icons.code,
                    label: 'Задачи',
                    onTap: () => Navigator.pushNamed(context, '/tasks'),
                  ),
                  _HomeIconButton(
                    icon: Icons.info_outline,
                    label: 'О компании',
                    onTap: () => Navigator.pushNamed(context, '/company'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HomeIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}
