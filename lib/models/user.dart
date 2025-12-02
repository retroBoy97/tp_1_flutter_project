class User {
  String email;
  String fullName;

  User({this.email = '', this.fullName = ''});

  @override
  String toString() {
    return 'User{email: $email, fullName: $fullName}';
  }
}
