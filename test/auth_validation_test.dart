import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonut_app_flutter/auth/login_code_screen.dart';
import 'package:jdonut_app_flutter/auth/login_date_screen.dart';
import 'package:jdonut_app_flutter/auth/login_name_screen.dart';
import 'package:jdonut_app_flutter/auth/login_phone_screen.dart';
import 'package:jdonut_app_flutter/auth/viewmodels/login_code_viewmodel.dart';
import 'package:jdonut_app_flutter/routing/routes.dart';
import 'package:pinput/pinput.dart';

void main() {
  group('Login Phone Screen Validation', () {
    testWidgets('Continue stays disabled for invalid phone and enables on valid input',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginPhoneScreen(),
        ),
      );

      final continueButton = find.widgetWithText(TextButton, 'CONTINUE');
      expect(tester.widget<TextButton>(continueButton).onPressed, isNull);

      final textField = find.byType(TextField);

      // Enter invalid phone
      await tester.enterText(textField, '1234');
      await tester.pump();
      expect(tester.widget<TextButton>(continueButton).onPressed, isNull);

      // Enter valid phone (09254135592)
      await tester.enterText(textField, '09254135592');
      await tester.pump();
      expect(tester.widget<TextButton>(continueButton).onPressed, isNotNull);
    });

    testWidgets('Inline error message appears when field loses focus with invalid input',
        (WidgetTester tester) async {
      final focusNode = FocusNode();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Expanded(child: const LoginPhoneScreen()),
                TextField(focusNode: focusNode),
              ],
            ),
          ),
        ),
      );

      final phoneTextField = find.byType(TextField).first;
      await tester.enterText(phoneTextField, '09123');
      await tester.pump();

      // Focus second textfield to trigger loss of focus on phone field
      await tester.tap(find.byType(TextField).last);
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid phone number (e.g. 09254135592)'),
          findsOneWidget);
    });
  });

  group('Login Code Screen Validation', () {
    testWidgets('Fake code 123456 passes and wrong code triggers error & lock after 3 attempts',
        (WidgetTester tester) async {
      final args = OtpCodeArgs(phone: '+959254135592', expireIn: 300);

      final router = GoRouter(
        initialLocation: Routes.loginCode,
        routes: [
          GoRoute(
            path: Routes.loginCode,
            builder: (context, state) => LoginCodeScreen(args: args),
          ),
          GoRoute(
            path: Routes.loginName,
            builder: (context, state) => const Text('Name Screen'),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      final pinput = find.byType(Pinput);
      expect(pinput, findsOneWidget);

      // Attempt 1 wrong code
      await tester.enterText(find.byType(EditableText).first, '111111');
      await tester.pumpAndSettle();

      expect(find.text('Invalid verification code. Please try again.'),
          findsOneWidget);

      // Attempt 2 wrong code
      await tester.enterText(find.byType(EditableText).first, '222222');
      await tester.pumpAndSettle();

      expect(find.text('Invalid verification code. Please try again.'),
          findsOneWidget);

      // Attempt 3 wrong code
      await tester.enterText(find.byType(EditableText).first, '333333');
      await tester.pumpAndSettle();

      expect(find.text('3 wrong codes. Entry is locked until you tap Resend.'),
          findsOneWidget);

      // Pinput should now be disabled
      final pinputWidget = tester.widget<Pinput>(pinput);
      expect(pinputWidget.enabled, isFalse);

      // Tap Resend to unlock
      final resendBtn = find.text('Resend');
      expect(resendBtn, findsOneWidget);
      await tester.tap(resendBtn);
      await tester.pumpAndSettle();

      // Entry should be unlocked
      final unlockedPinput = tester.widget<Pinput>(find.byType(Pinput));
      expect(unlockedPinput.enabled, isTrue);
      expect(find.text('3 wrong codes. Entry is locked until you tap Resend.'),
          findsNothing);

      // Now enter valid fake code 123456
      await tester.enterText(find.byType(EditableText).first, '123456');
      await tester.pumpAndSettle();

      expect(find.text('Name Screen'), findsOneWidget);
    });
  });

  group('Login Name Screen Validation', () {
    testWidgets('Validates required first name and optional last name with Myanmar script support',
        (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: Routes.loginName,
        routes: [
          GoRoute(
            path: Routes.loginName,
            builder: (context, state) => const LoginNameScreen(),
          ),
          GoRoute(
            path: Routes.loginDate,
            builder: (context, state) => const Text('Date Screen'),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      final firstField = find.byWidgetPredicate(
        (widget) => widget is TextField && widget.decoration?.hintText == 'First Name',
      );
      final lastField = find.byWidgetPredicate(
        (widget) => widget is TextField && widget.decoration?.hintText == 'Last Name',
      );
      final continueBtn = find.widgetWithText(TextButton, 'CONTINUE');

      // Tap continue with empty first name -> Error
      await tester.tap(continueBtn);
      await tester.pumpAndSettle();

      expect(find.text('First name is required'), findsOneWidget);

      // Enter digits in first name -> Error
      await tester.enterText(firstField, 'John123');
      await tester.tap(continueBtn);
      await tester.pumpAndSettle();
      expect(find.text('First name cannot contain digits'), findsOneWidget);

      // Enter valid English & Myanmar name in first name, but digits in last name
      await tester.enterText(firstField, 'အောင် ဆန်း');
      await tester.enterText(lastField, 'Smith99');
      await tester.tap(continueBtn);
      await tester.pumpAndSettle();
      expect(find.text('First name is required'), findsNothing);
      expect(find.text('First name cannot contain digits'), findsNothing);
      expect(find.text('Last name cannot contain digits'), findsOneWidget);

      // Clear last name (optional) and continue -> Navigates to Date Screen
      await tester.enterText(lastField, '');
      await tester.tap(continueBtn);
      await tester.pumpAndSettle();

      expect(find.text('Date Screen'), findsOneWidget);
    });
  });

  group('Login Date Screen Validation', () {
    test('Named constant minAge is 13', () {
      expect(LoginDateScreen.minAge, equals(13));
    });

    testWidgets('Initial date defaults to minAge (13 years ago) and validates date requirements',
        (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: Routes.loginDate,
        routes: [
          GoRoute(
            path: Routes.loginDate,
            builder: (context, state) => const LoginDateScreen(),
          ),
          GoRoute(
            path: Routes.main,
            builder: (context, state) => const Text('Main Screen'),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      final continueBtn = find.widgetWithText(TextButton, 'CONTINUE');

      // Default date (13 years ago) should be valid and proceed to Main Screen
      await tester.tap(continueBtn);
      await tester.pumpAndSettle();

      expect(find.text('Main Screen'), findsOneWidget);
    });
  });
}
