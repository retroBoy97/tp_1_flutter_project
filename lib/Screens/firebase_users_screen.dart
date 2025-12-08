import 'package:flutter/material.dart';
import '../models/firebase_user.dart';
import '../services/firebase_user_service.dart';

/// Screen to display, add, and delete users from Firebase
/// Uses StreamBuilder for real-time updates
class FirebaseUsersScreen extends StatefulWidget {
  static const String routeName = '/firebase-users';

  const FirebaseUsersScreen({super.key});

  @override
  State<FirebaseUsersScreen> createState() => _FirebaseUsersScreenState();
}

class _FirebaseUsersScreenState extends State<FirebaseUsersScreen> {
  final FirebaseUserService _userService = FirebaseUserService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  /// Show dialog to add a new user
  void _showAddUserDialog() {
    _nameController.clear();
    _emailController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un utilisateur'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nom',
                hintText: 'Entrez le nom',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Entrez l\'email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty &&
                  _emailController.text.isNotEmpty) {
                _userService.addUser(FirebaseUser(
                  name: _nameController.text,
                  email: _emailController.text,
                ));
                Navigator.pop(context);
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  /// Show confirmation dialog before deleting
  void _confirmDelete(FirebaseUser user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer'),
        content: Text('Voulez-vous supprimer ${user.name} ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              _userService.deleteUser(user.id!);
              Navigator.pop(context);
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Users'),
        backgroundColor: Colors.orange,
      ),
      // StreamBuilder for real-time updates (Exercice Q2)
      body: StreamBuilder<List<FirebaseUser>>(
        stream: _userService.getUsers(),
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          // Empty state
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Aucun utilisateur.\nAppuyez sur + pour ajouter.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          // Display users with ListView.Builder
          final users = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Text(
                      user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(user.email),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmDelete(user),
                  ),
                ),
              );
            },
          );
        },
      ),
      // FAB to add new user
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddUserDialog,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
