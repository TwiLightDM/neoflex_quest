import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:neoflex_quest/services/coin_manager.dart';

import '../models/shop_item.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<dynamic> items = [];
  int _coins = 0;

  @override
  void initState() {
    super.initState();
    loadShopItems();
    loadCoins();
  }

  Future<void> loadShopItems() async {
    final String response = await rootBundle.loadString('lib/assets/data/shop_items.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      items = data;
    });
  }

  Future<void> loadCoins() async {
    final coins = await CoinManager.getCoins();
    setState(() {
      _coins = coins;
    });
  }

  Future<void> buyItem(int price) async {
    final currentCoins = await CoinManager.getCoins();
    if (currentCoins >= price) {
      await CoinManager.addCoins(-price);
      await loadCoins();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Покупка успешна! 🎉'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Недостаточно монет 😢'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Магазин'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text('$_coins монет'),
            ),
          )
        ],
      ),
      body: items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
            itemBuilder: (context, index) {
              final item = items[index];
              final isDark = Theme.of(context).brightness == Brightness.dark;

              return Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[850] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: ShopItem(
                  imagePath: item['image'],
                  name: item['name'],
                  price: item['price'],
                  onBuy: () => buyItem(item['price']),
                  textColor: isDark ? Colors.white : Colors.black,
                ),
              );
            }
        ),
      ),
    );
  }
}