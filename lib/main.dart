import 'package:flutter/material.dart';
import 'Screens/HomeScreen/home_screen.dart';
import 'Screens/Library/library_screen.dart';
import 'package:tp_1/models/book.dart';

void main() {
  List<Book> books = [
    Book('Crime et Châtiment', 30, 'assets/Crime et chatiment.jpg'),
    Book('L\'Homme qui Voulait Être Heureux', 25, 'assets/L\'homme qui voulait etre heureux.jpg'),
    Book('Les Misérables', 40, 'assets/Les miserables.jpg'),
  ];

  runApp(MyApp(books: books));
}

class MyApp extends StatelessWidget {
  final List<Book> books;

  const MyApp({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LibraryScreen(books: books),
    );
  }
}