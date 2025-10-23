import 'package:flutter/material.dart';
import 'package:tp_1/models/book.dart';

// Variable globale pour la quantité
int quantity = 10;

class DetailsScreen extends StatefulWidget {
  final Book book;

  const DetailsScreen({super.key, required this.book});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 107, 235),
        title: Text(
          widget.book.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          // 1. Image
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  widget.book.image,
                  width: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.error,
                    size: 250,
                  ),
                ),
              ),
            ),
          ),

          // 2. Affichage de la quantité disponible
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Quantité disponible: $quantity",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          // 3. Description
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Lorem ipsum dolor sit amet consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultricies diam. Maecenas ligula massa, varius a, semper congue.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),

          // 4. Price
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${widget.book.price.toString()} TND",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // 5. Buy button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 33, 107, 235),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                setState(() {
                  if (quantity > 0) {
                    quantity--;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Livre acheté! Quantité restante: $quantity',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Stock épuisé!'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                });
              },
              icon: const Icon(Icons.shopping_bag),
              label: const Text(
                "Purchase",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

