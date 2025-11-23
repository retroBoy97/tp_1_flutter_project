import 'package:flutter/material.dart';
import 'package:tp_1/models/book.dart';
import 'library_cell.dart';
import '../DetailsScreen/details_screen.dart';

class LibraryScreen extends StatelessWidget {
  static const String routeName = "/library";
  final List<Book> books;

  const LibraryScreen({super.key, required this.books});

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
              "Bibliothèque",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.9,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Using Named Route Navigation
                    Navigator.pushNamed(
                      context,
                      DetailsScreen.routeName,
                      arguments: books[index],
                    );
                  },
                  child: LibraryCell(book: books[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
