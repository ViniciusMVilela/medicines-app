import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../screen/home.dart'; 
import '../models/user.dart';

void main() {
  testWidgets('Home displays user information', (WidgetTester tester) async {
    final User testUser = User(
      id: '1',
      name: 'Henrique',
      email: 'henrique@test.com',
      password: 'password123',
      telephone: '1234567890',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Home(user: testUser),
      ),
    );

    expect(find.text('Henrique'), findsOneWidget);
    expect(find.text('henrique@test.com'), findsOneWidget);
    expect(find.text('1234567890'), findsOneWidget);
  });
}
