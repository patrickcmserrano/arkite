import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arkite/io/drift_repository.dart';
import 'package:arkite/kernel/providers/core_providers.dart';
import 'package:arkite/ui/design_system/app_theme.dart';
import 'package:arkite/ui/features/settings/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Drift Database
  final driftRepo = DriftRepository();
  await driftRepo.init();

  runApp(
    ProviderScope(
      overrides: [driftRepositoryProvider.overrideWithValue(driftRepo)],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiKeyAsync = ref.watch(apiKeyProvider);

    return MaterialApp(
      title: 'Prompt IDE',
      theme: AppTheme.darkTheme,
      home: apiKeyAsync.when(
        data: (apiKey) {
          if (apiKey == null) {
            return const WelcomeScreen();
          }
          // TODO: Replace with Project List / Chat Screen
          return const Scaffold(
            body: Center(
              child: Text('Authenticated! Project List coming soon.'),
            ),
          );
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (err, stack) =>
            Scaffold(body: Center(child: Text('Error: $err'))),
      ),
    );
  }
}
