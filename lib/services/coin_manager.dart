import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CoinManager {
  static Database? _db;
  static final ValueNotifier<int> coins = ValueNotifier(0);

  static Future<void> init() async {
    if (_db != null) return;

    Directory docsDir = await getApplicationDocumentsDirectory();
    String path = join(docsDir.path, 'coins.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE coins (
            id INTEGER PRIMARY KEY,
            amount INTEGER
          )
        ''');
        await db.insert('coins', {'id': 0, 'amount': 0});
      },
    );

    int current = await getCoins();
    coins.value = current;
  }

  static Future<int> getCoins() async {
    final db = _db!;
    final res = await db.query('coins', where: 'id = ?', whereArgs: [0]);
    return res.isNotEmpty ? res.first['amount'] as int : 0;
  }

  static Future<void> addCoins(int amount) async {
    final db = _db!;
    final current = await getCoins();
    final newTotal = current + amount;
    print('Добавляем $amount монет. Было $current → стало $newTotal');
    await db.update('coins', {'amount': newTotal}, where: 'id = ?', whereArgs: [0]);
    coins.value = newTotal;
  }

  static Future<bool> spendCoins(int amount) async {
    final db = _db!;
    final current = await getCoins();
    if (current >= amount) {
      final newTotal = current - amount;
      await db.update('coins', {'amount': newTotal}, where: 'id = ?', whereArgs: [0]);
      coins.value = newTotal;
      return true;
    }
    return false;
  }
}
