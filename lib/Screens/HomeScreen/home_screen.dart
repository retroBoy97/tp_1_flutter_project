import 'package:flutter/material.dart';
import 'package:tp_1/models/book.dart'; // Ensure this matches your project name
import 'home_cell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 107, 235),
        title: const Text(
          "Store INSAT",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeCell(
              book: Book('Crime et Châtiment', 30, 'assets/Crime et chatiment.jpg'),
            ),
            HomeCell(
              book: Book('L\'Homme qui Voulait Être Heureux', 25, 'assets/L\'homme qui voulait etre heureux.jpg'),
            ),
            HomeCell(
              book: Book('Les Misérables', 40, 'assets/Les miserables.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}