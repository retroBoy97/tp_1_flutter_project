import 'package:flutter/material.dart';
import 'package:tp_1/models/book.dart';
import 'home_cell.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";
  final List<Book> books;

  const HomeScreen({super.key, required this.books});

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
          children: books.map((book) => HomeCell(book: book)).toList(),
        ),
      ),
    );
  }
}
