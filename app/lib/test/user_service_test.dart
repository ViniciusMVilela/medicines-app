import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../models/User.dart'; 
import '../service/app.service.dart';  

class MockClient extends Mock implements http.Client {}

void main() {
 test('getUserById returns user when id matches', () async {
  final mockClient = MockClient();
  final userService = UserService(client: mockClient);

  final mockResponse = jsonEncode({
    'id': '1',
    'name': 'Henrique',
    'email': 'henrique@test.com',
    'password': 'password123',
    'telephone': '1234567890',
  });

  when(mockClient.get(Uri.parse('http://localhost:3000/api/users/1')))
      .thenAnswer((_) async => http.Response(mockResponse, 200));

  final user = await userService.getUserById('1');

  expect(user?.name, 'Henrique');
  expect(user?.id, '1');
});


   test('createUser', () async {
    final mockClient = MockClient();
    final userService = UserService(client: mockClient);

    final newUser = User(
      id: '',
      name: 'Henrique',
      email: 'henrique@test.com',
      password: 'password123',
      telephone: '1234567890',
    );

    final mockResponse = jsonEncode({
      'id': '1',
      'name': 'Henrique',
      'email': 'henrique@test.com',
      'password': 'password123',
      'telephone': '1234567890',
    });

    when(mockClient.post(
      Uri.parse('http://localhost:3000/api/users'), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': newUser.name,
        'email': newUser.email,
        'telephone': newUser.telephone,
      }),
    )).thenAnswer((_) async => http.Response(mockResponse, 201));

    final createdUser = await userService.createUser(newUser);

    expect(createdUser.id, '1');
    expect(createdUser.name, 'Henrique');
    expect(createdUser.email, 'henrique@test.com');
    expect(createdUser.telephone, '1234567890');
  });
}
