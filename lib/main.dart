import 'package:flutter/material.dart';
import 'screens/signup_screen.dart';
import 'screens/HomeScreen/home_screen.dart';
import 'screens/DetailsScreen/details_screen.dart';
import 'screens/Library/library_screen.dart';
import 'models/book.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  List<Book> get sampleBooks => [
    Book('Crime et Châtiment', 30, 'assets/Crime et chatiment.jpg'),
    Book('L\'Homme qui Voulait Être Heureux', 25, 'assets/L\'homme qui voulait etre heureux.jpg'),
    Book('Les Misérables', 40, 'assets/Les miserables.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Page affichée au lancement
      initialRoute: SignUpScreen.routeName,

      // Déclaration des routes
      routes: {
        SignUpScreen.routeName: (context) => SignUpScreen(),
        HomeScreen.routeName: (context) => HomeScreen(books: sampleBooks),
        DetailsScreen.routeName: (context) => DetailsScreen(),
        LibraryScreen.routeName: (context) => LibraryScreen(books: sampleBooks),
      },
    );
  }
}
