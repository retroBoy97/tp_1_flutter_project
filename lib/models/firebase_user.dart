import 'package:cloud_firestore/cloud_firestore.dart';

/// Model for Firebase Firestore user
class FirebaseUser {
  final String? id;
  final String name;
  final String email;

  FirebaseUser({
    this.id,
    required this.name,
    required this.email,
  });

  /// Create FirebaseUser from Firestore document
  factory FirebaseUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FirebaseUser(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }

  /// Convert FirebaseUser to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
    };
  }
}
