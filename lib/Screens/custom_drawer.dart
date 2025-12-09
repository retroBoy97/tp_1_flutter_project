import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final Icon icon;
  final VoidCallback onTap;

  DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

class CustomDrawer extends StatelessWidget {
  final List<DrawerItem> items;

  const CustomDrawer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 33, 107, 235),
          title: const Text(
            "Navigation",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/insat.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 107, 235),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.store,
                        size: 50,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Store INSAT",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 33, 107, 235),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: ListTile(
                      leading: item.icon,
                      title: Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: item.onTap,
                      tileColor: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}