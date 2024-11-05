class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String telephone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.telephone
  });

 String get getFullName => name.trim();
 String get getEmail => email;
 String get getTelephone => telephone;

}

