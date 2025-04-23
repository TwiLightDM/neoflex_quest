import 'package:flutter/material.dart';
import 'package:neoflex_quest/services/coin_manager.dart';
import '../models/home_icon_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
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

  // Функция для загрузки монет
  Future<void> _loadCoins() async {
    final coins = await CoinManager.getCoins();
    setState(() {
      _coins = coins;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        actions: [
          Center(child: Text('$_coins монет')),
          const SizedBox(width: 16),
        ],
      ),
      body: const Center(
        child: Text(
          'Добро пожаловать!',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HomeIconButton(
              icon: Icons.quiz,
              label: 'Квиз',
              onTap: () => Navigator.pushNamed(context, '/quiz'),
            ),
            HomeIconButton(
              icon: Icons.code,
              label: 'Задачи',
              onTap: () => Navigator.pushNamed(context, '/tasks'),
            ),
            HomeIconButton(
              icon: Icons.shopping_cart,
              label: 'Магазин',
              onTap: () => Navigator.pushNamed(context, '/shop'),
            ),
            HomeIconButton(
              icon: Icons.emoji_events,
              label: 'Ачивки',
              onTap: () => Navigator.pushNamed(context, '/achievements'),
            ),
            HomeIconButton(
              icon: Icons.info,
              label: 'О компании',
              onTap: () => Navigator.pushNamed(context, '/company'),
            ),
          ],
        ),
      ),
    );
  }
}
