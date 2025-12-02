import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserService {
  static const String _keyEmail = "current_user_email";
  static const String _keyName = "current_user_name";

  /// Sauvegarder les informations de l'utilisateur dans SharedPreferences
  Future<void> saveCurrentUser(User user) async {
    await SharedPreferences.getInstance().then((sp) async {
      await sp.setString(_keyEmail, user.email);
      await sp.setString(_keyName, user.fullName);
      print("User Saved Successfully!");
    });
  }

  /// Retourne l'utilisateur si trouvé dans SharedPreferences
  Future<User?> getCurrentUser() async {
    User? user;
    await SharedPreferences.getInstance().then((sp) {
      String? email = sp.getString(_keyEmail);
      String? fullName = sp.getString(_keyName);
      
      if (email != null && fullName != null) {
        user = User(email: email, fullName: fullName);
        print("User Retrieved Successfully!");
      } else {
        print("No user found in SharedPreferences");
      }
    });
    return user;
  }

  /// Supprimer les données locales de l'utilisateur
  Future<void> clearCurrentUser() async {
    await SharedPreferences.getInstance().then((sp) async {
      await sp.remove(_keyEmail);
      await sp.remove(_keyName);
      print("User Data Cleared Successfully!");
    });
  }
}
