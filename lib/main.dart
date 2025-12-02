import 'package:flutter/material.dart';
import 'Screens/signup_screen.dart';
import 'Screens/HomeScreen/home_screen.dart';
import 'Screens/DetailsScreen/details_screen.dart';
import 'Screens/Library/library_screen.dart';
import 'Screens/basket_screen.dart';
import 'Screens/bottom_nav_bar.dart';
import 'Screens/tab_bar_screen.dart';
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
        HomeScreen.routeName: (context) => BottomNavBar(books: sampleBooks),
        DetailsScreen.routeName: (context) => DetailsScreen(),
        LibraryScreen.routeName: (context) => LibraryScreen(books: sampleBooks),
        BasketScreen.routeName: (context) => const BasketScreen(),
        BottomNavBar.routeName: (context) => BottomNavBar(books: sampleBooks),
        TabBarScreen.routeName: (context) => TabBarScreen(books: sampleBooks),
      },
    );
  }
}
