import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab10/RegisterPage.dart';
import 'package:lab10/SignInPage.dart';
import 'package:lab10/main.dart';
import 'package:lab10/sport.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();
  setUp(() async {
    await Firebase.initializeApp();
  });

  testWidgets('SignInPage has email and password input fields and a register button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInPage()));

    final emailFieldFinder = find.byType(TextFormField).at(0);
    final passwordFieldFinder = find.byType(TextFormField).at(1);

    expect(emailFieldFinder, findsOneWidget);
    expect(passwordFieldFinder, findsOneWidget);

    await tester.enterText(emailFieldFinder, 'test@example.com');
    await tester.enterText(passwordFieldFinder, 'password');

    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);

    expect(find.widgetWithText(TextButton, 'Регистрация'), findsOneWidget);
  });

  testWidgets('Tap on "Регистрация" button navigates to RegisterPage', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SignInPage(),
      routes: {
        '/register': (context) => RegisterPage(),
      },
    ));

    final registerButtonFinder = find.widgetWithText(TextButton, 'Регистрация');

    expect(registerButtonFinder, findsOneWidget);

    await tester.tap(registerButtonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(RegisterPage), findsOneWidget);
  });

  testWidgets('Items in ListView can be scrolled', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(title: Text('Item $index'));
          },
        ),
      ),
    ));

    expect(find.text('Item 0'), findsOneWidget);

    await tester.drag(find.byType(ListView), Offset(0, -300));
    await tester.pumpAndSettle();

    expect(find.text('Item 0'), findsNothing);
  });
}
