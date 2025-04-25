import 'package:flutter/material.dart';
import '../models/achievement.dart';
import '../services/achievement_service.dart'; // путь к AchievementService

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  List<Achievement> _achievements = [];

  @override
  void initState() {
    super.initState();
    _loadAchievements();
  }

  Future<void> _loadAchievements() async {
    await AchievementService.init();
    setState(() {
      _achievements = AchievementService.all; // или .unlockedAchievements, если нужны только открытые
    });
  }

  @override
  Widget build(BuildContext context) {
    final unlocked = _achievements.where((a) => a.unlocked).toList();
    final locked = _achievements.where((a) => !a.unlocked).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Достижения')),
      body: ListView(
        children: [
          if (unlocked.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Разблокированные',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...unlocked.map((achievement) => _buildAchievementTile(achievement)),
          ],
          if (locked.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Неполученные',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
            ...locked.map((achievement) => _buildAchievementTile(achievement)),
          ]
        ],
      ),
    );
  }

  Widget _buildAchievementTile(Achievement achievement) {
    return ListTile(
      leading: Icon(
        achievement.unlocked ? Icons.emoji_events : Icons.lock_outline,
        color: achievement.unlocked ? Colors.amber : Colors.grey,
      ),
      title: Text(achievement.title),
      subtitle: Text(achievement.description),
    );
  }
}
