import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Главная',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/achievements': (_) => const AchievementsPage(),
        '/daily': (_) => const DailyTasksPage(),
        '/shop': (_) => const ShopPage(),
        '/tasks': (_) => const ProgrammingTasksPage(),
        '/company': (_) => const CompanyInfoPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Верхняя панель
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Главная',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.emoji_events_outlined),
                    iconSize: 32, // <-- добавлено
                    onPressed: () {
                      Navigator.pushNamed(context, '/achievements');
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // Прогресс-бар
            const Center(
              child: CircularProgressIndicator(
                value: 0.6,
              ),
            ),

            const Spacer(),

            // Горизонтальные кнопки с иконками
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

// Виджет для кнопок с иконкой и подписью
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

// Все страницы-заглушки внутри файла
class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ачивки')),
      body: const Center(child: Text('Achievements page')),
    );
  }
}

class DailyTasksPage extends StatelessWidget {
  const DailyTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Дейлики')),
      body: const Center(child: Text('Daily Tasks Page')),
    );
  }
}

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Магазин')),
      body: const Center(child: Text('Shop Page')),
    );
  }
}

class ProgrammingTasksPage extends StatelessWidget {
  const ProgrammingTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Задачи')),
      body: const Center(child: Text('Programming Tasks Page')),
    );
  }
}

class CompanyInfoPage extends StatelessWidget {
  const CompanyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('О компании')),
      body: const Center(child: Text('Company Info Page')),
    );
  }

}