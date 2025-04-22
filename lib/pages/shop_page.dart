import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:neoflex_quest/services/coin_manager.dart';

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
      await CoinManager.addCoins(-price); // тратим
      await loadCoins(); // обновим баланс
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
            return ShopItem(
              imagePath: item['image'],
              price: item['price'],
              onBuy: () => buyItem(item['price']),
            );
          },
        ),
      ),
    );
  }
}

class ShopItem extends StatelessWidget {
  final String imagePath;
  final int price;
  final VoidCallback onBuy;

  const ShopItem({
    required this.imagePath,
    required this.price,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  '$price монет',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange[800],
                  ),
                ),
                const SizedBox(height: 6),
                ElevatedButton(
                  onPressed: onBuy,
                  child: const Text("Купить"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
