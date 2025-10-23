import 'package:flutter/material.dart';
import 'package:tp_1/models/book.dart';
import 'library_cell.dart';
import '../DetailsScreen/details_screen.dart';

class LibraryScreen extends StatelessWidget {
  final List<Book> books;

  const LibraryScreen({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 107, 235),
        centerTitle: true,
        title: const Text(
          "Store INSAT",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(book: books[index]),
                  ),
                );
              },
              child: LibraryCell(book: books[index]),
            );
          },
        ),
      ),
    );
  }
}
