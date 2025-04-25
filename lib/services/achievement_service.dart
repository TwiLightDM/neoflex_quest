import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/achievement.dart';

class AchievementService {
  static final List<Achievement> _achievements = [];
  static const _unlockedKey = 'unlocked_achievements';

  static Future<void> init() async {
    // 1. Загружаем список достижений из assets
    final String data = await rootBundle.loadString('lib/assets/data/achievements.json');
    final List<dynamic> jsonResult = json.decode(data);

    // 2. Загружаем сохранённые unlocked-флаги
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> unlockedIds = prefs.getStringList(_unlockedKey) ?? [];

    // 3. Комбинируем данные
    _achievements.clear();
    _achievements.addAll(jsonResult.map((e) {
      final achievement = Achievement.fromJson(e);
      if (unlockedIds.contains(achievement.id)) {
        achievement.unlock();
      }
      return achievement;
    }));
  }

  static Future<void> unlock(BuildContext context, String id) async {
    final index = _achievements.indexWhere((a) => a.id == id);
    if (index != -1 && !_achievements[index].unlocked) {
      _achievements[index].unlock();

      // Сохраняем в SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> unlockedIds = prefs.getStringList(_unlockedKey) ?? [];
      unlockedIds.add(id);
      await prefs.setStringList(_unlockedKey, unlockedIds);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('🎉 Достижение разблокировано: ${_achievements[index].title}')),
      );
    }
  }

  static List<Achievement> get unlockedAchievements =>
      _achievements.where((a) => a.unlocked).toList();

  static List<Achievement> get all => List.unmodifiable(_achievements);
}