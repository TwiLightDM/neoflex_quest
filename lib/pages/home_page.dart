import 'package:flutter/material.dart';
import 'package:neoflex_quest/services/coin_manager.dart';
import '../models/home_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _coins = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _loadCoins();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Добро пожаловать!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -_animation.value),
                  child: child,
                );
              },
              child: SvgPicture.asset(
                'lib/assets/images/neo/neonchik.svg',
                height: 180,

              ),
            ),
          ],
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
