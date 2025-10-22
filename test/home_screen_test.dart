import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tp_1/Screens/homeScreen/home_screen.dart';

void main() {
  testWidgets('HomeScreen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    expect(find.text('Store INSAT'), findsOneWidget);
    expect(find.text('Welcome to Store INSAT!'), findsOneWidget);
    expect(tester.widget<AppBar>(find.byType(AppBar)).backgroundColor, 
           const Color.fromARGB(255, 33, 107, 235));
    expect(tester.widget<Text>(find.text('Store INSAT')).style?.fontSize, 30);
  });
}