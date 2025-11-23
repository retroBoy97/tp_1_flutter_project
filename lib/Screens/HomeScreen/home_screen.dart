import 'package:flutter/material.dart';
import 'package:tp_1/models/book.dart';
import 'home_cell.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";
  final List<Book> books;

  const HomeScreen({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: books.map((book) => HomeCell(book: book)).toList(),
      ),
    );
  }
}
