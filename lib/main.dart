import 'package:flutter/material.dart';
import 'Screens/signup_screen.dart';
import 'Screens/HomeScreen/home_screen.dart';
import 'Screens/DetailsScreen/details_screen.dart';
import 'Screens/Library/library_screen.dart';
import 'Screens/basket_screen.dart';
import 'Screens/bottom_nav_bar.dart';
import 'Screens/tab_bar_screen.dart';
import 'models/book.dart';
import 'models/user.dart';
import 'services/user_service.dart';

void main() async {
  // Nécessaire pour utiliser SharedPreferences avant runApp
  WidgetsFlutterBinding.ensureInitialized();
  
  // TEST SHARED PREFERENCES
  await testSharedPreferences();
  
  runApp(const MyApp());
}

/// Fonction de test pour SharedPreferences
Future<void> testSharedPreferences() async {
  UserService userService = UserService();
  
  User testUser = User(
    email: "kacem@insat.tn",
    fullName: "Kacem Ben Ali",
  );
  print("\n1. Utilisateur créé: $testUser");
  
  // 2. Sauvegarder l'utilisateur
  print("\n2. Sauvegarde de l'utilisateur...");
  await userService.saveCurrentUser(testUser);
  
  // 3. Récupérer l'utilisateur
  print("\n3. Récupération de l'utilisateur...");
  User? retrievedUser = await userService.getCurrentUser();
  if (retrievedUser != null) {
    print("   Utilisateur récupéré: $retrievedUser");
  }
  
  // 4. Supprimer l'utilisateur
  print("\n4. Suppression de l'utilisateur...");
  await userService.clearCurrentUser();
  
  // 5. Vérifier la suppression
  print("\n5. Vérification après suppression...");
  User? deletedUser = await userService.getCurrentUser();
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
