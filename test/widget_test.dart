import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arkite/main.dart';
import 'package:arkite/kernel/providers/core_providers.dart';
import 'package:arkite/ui/features/settings/welcome_screen.dart';

void main() {
  testWidgets('App starts and shows WelcomeScreen when unauthenticated', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [apiKeyProvider.overrideWith((ref) async => null)],
        child: const MainApp(),
      ),
    );

    // Initial build should show loading state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Trigger a frame to allow the Future to complete
    await tester.pump();

    // Verify that we are on the Welcome Screen
    expect(find.byType(WelcomeScreen), findsOneWidget);
    expect(find.text('Welcome to Prompt IDE'), findsOneWidget);
  });
}
