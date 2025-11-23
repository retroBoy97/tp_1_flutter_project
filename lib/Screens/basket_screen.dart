import 'package:flutter/material.dart';

class BasketScreen extends StatelessWidget {
  static const String routeName = "/basket";

  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Votre panier est vide',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}