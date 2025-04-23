import 'package:flutter/material.dart';

class ShopItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final int price;
  final VoidCallback onBuy;
  final Color textColor;

  const ShopItem({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.onBuy,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Image.asset(imagePath)),
        const SizedBox(height: 8),
        Text(name, style: TextStyle(fontSize: 16, color: textColor)),
        const SizedBox(height: 4),
        Text('$price монет', style: TextStyle(fontSize: 14, color: textColor)),
        const SizedBox(height: 6),
        ElevatedButton(
          onPressed: onBuy,
          child: const Text('Купить'),
        )
      ],
    );
  }
}