import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/firebase_user.dart';

/// Service for Firebase Firestore CRUD operations on users
class FirebaseUserService {
  // Reference to the 'users' collection in Firestore
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  /// Get all users as a Stream (real-time updates for StreamBuilder)
  Stream<List<FirebaseUser>> getUsers() {
    return _usersCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => FirebaseUser.fromFirestore(doc))
          .toList();
    });
  }

  /// Add a new user
  Future<void> addUser(FirebaseUser user) async {
    await _usersCollection.add(user.toFirestore());
  }

  /// Delete a user by ID
  Future<void> deleteUser(String id) async {
    await _usersCollection.doc(id).delete();
  }

  /// Update a user
  Future<void> updateUser(FirebaseUser user) async {
    if (user.id != null) {
      await _usersCollection.doc(user.id).update(user.toFirestore());
    }
  }
}
