import 'package:flutter/material.dart';
import 'package:tp_1/models/book.dart';
import 'HomeScreen/home_screen.dart';
import 'Library/library_screen.dart';
import 'basket_screen.dart';
import 'custom_drawer.dart';
import 'tab_bar_screen.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = "/bottomNavBar";
  final List<Book> books;
  
  const BottomNavBar({super.key, required this.books});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var mCurrentIndex = 0; 

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomeScreen(books: widget.books),
      LibraryScreen(books: widget.books),
      const BasketScreen(),
    ];

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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: CustomDrawer(
        "Tab Navigation",
        const Icon(Icons.tab),
        () {
          Navigator.pushReplacementNamed(context, TabBarScreen.routeName);
        },
      ),
      body: pages[mCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 33, 107, 235),
        unselectedItemColor: Colors.grey,
        currentIndex: mCurrentIndex,
        onTap: (value) {
          setState(() {
            mCurrentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "Basket",
          ),
        ],
      ),
    );
  }
}