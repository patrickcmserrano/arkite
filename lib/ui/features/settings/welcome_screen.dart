import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arkite/kernel/providers/core_providers.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final _controller = TextEditingController();
  bool _isLoading = false;
  String? _error;

  Future<void> _saveApiKey() async {
    final key = _controller.text.trim();
    if (key.isEmpty) {
      setState(() => _error = 'Please enter a valid API Key');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await ref.read(secureStorageProvider).saveApiKey(key);
      // Invalidate the provider to trigger a reload/navigation in main
      ref.invalidate(apiKeyProvider);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome to Prompt IDE',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'To get started, please enter your Google Gemini API Key. '
                    'It will be stored securely on your device.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'API Key',
                      border: const OutlineInputBorder(),
                      errorText: _error,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _isLoading ? null : _saveApiKey,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Get Started'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
