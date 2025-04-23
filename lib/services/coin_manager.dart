import 'db.dart';
import 'package:flutter/foundation.dart';

class CoinManager {
  static final ValueNotifier<int> coins = ValueNotifier<int>(0);

  static Future<void> init() async {
    final db = await AppDatabase.instance;
    await db.execute('''
      CREATE TABLE IF NOT EXISTS coins (
        id INTEGER PRIMARY KEY,
        amount INTEGER
      )
    ''');

    final existing = await db.query('coins');
    if (existing.isEmpty) {
      await db.insert('coins', {'id': 0, 'amount': 0});
    }

    final current = await getCoins();
    coins.value = current;
  }

  static Future<int> getCoins() async {
    final db = await AppDatabase.instance;
    final res = await db.query('coins');
    return res.first['amount'] as int;
  }

  static Future<void> addCoins(int amount) async {
    final db = await AppDatabase.instance;
    final current = await getCoins();
    final newAmount = current + amount;
    await db.update('coins', {'amount': newAmount}, where: 'id = 0');
    coins.value = newAmount;
  }

  static Future<void> setCoins(int amount) async {
    final db = await AppDatabase.instance;
    await db.update('coins', {'amount': amount}, where: 'id = 0');
    coins.value = amount;
  }
}
