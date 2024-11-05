import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/User.dart';

class UserService {
  final http.Client client;

  UserService({required this.client});

  static const String baseUrl = 'http://localhost:3000/api/users';

  Future<User?> getUserById(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/$userId'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return User(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        password: data['password'],
        telephone: data['telephone'],
      );
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<List<User>> getAllUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) {
        return User(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          password: json['password'],
          telephone: json['telephone'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': user.name,
        'email': user.email,
        'telephone': user.telephone,
      }),
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      return User(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        password: data['password'],
        telephone: data['telephone'],
      );
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<User> updateUser(String userId, User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': user.name,
        'email': user.email,
        'telephone': user.telephone,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return User(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        password: data['password'],
        telephone: data['telephone'],
      );
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String userId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$userId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}
