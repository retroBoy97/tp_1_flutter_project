import 'package:flutter/material.dart';
import 'package:tp_1/models/book.dart';
import 'HomeScreen/home_screen.dart';
import 'Library/library_screen.dart';
import 'basket_screen.dart';
import 'custom_drawer.dart';
import 'bottom_nav_bar.dart';

class TabBarScreen extends StatefulWidget {
  static const String routeName = "/tabNavigation";
  final List<Book> books;
  
  const TabBarScreen({super.key, required this.books});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.home_outlined), text: "Home"),
            Tab(icon: Icon(Icons.bookmark_outline), text: "Library"),
            Tab(icon: Icon(Icons.shopping_bag), text: "Basket"),
          ],
        ),
      ),
      drawer: CustomDrawer(
        "Bottom Navigation",
        const Icon(Icons.navigation),
        () {
          Navigator.pushReplacementNamed(context, BottomNavBar.routeName);
        },
      ),
      body: TabBarView(
        controller: tabController,
        children: pages,
      ),
    );
  }
}