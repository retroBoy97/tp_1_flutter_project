import 'package:flutter/material.dart';

class BasketScreen extends StatelessWidget {
  static const String routeName = "/basket";

  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          color: const Color.fromARGB(255, 33, 107, 235),
          child: const SafeArea(
            child: Text(
              "Panier",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Votre panier est vide',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}