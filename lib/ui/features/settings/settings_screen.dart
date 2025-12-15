import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arkite/kernel/models/gemini_models.dart';
import 'package:arkite/kernel/providers/core_providers.dart';
import 'package:arkite/io/storage/secure_storage.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedModelIdAsync = ref.watch(selectedModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Gemini Model',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          selectedModelIdAsync.when(
            data: (selectedId) {
              return Column(
                children: availableModels.map((model) {
                  return RadioListTile<String>(
                    title: Text(model.name),
                    subtitle: Text(model.description),
                    value: model.id,
                    groupValue: selectedId,
                    onChanged: (value) async {
                      if (value != null) {
                        final storage = ref.read(secureStorageProvider);
                        await storage.saveModelId(value);
                        ref.invalidate(selectedModelProvider);
                        ref.invalidate(geminiServiceProvider);
                      }
                    },
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
          const Divider(),
          ListTile(
            title: const Text('API Key'),
            subtitle: const Text('Clear stored API key'),
            trailing: const Icon(Icons.delete_outline),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear API Key'),
                  content: const Text(
                    'Are you sure? You will be redirected to the welcome screen.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                final storage = ref.read(secureStorageProvider);
                await storage.clearApiKey();
                ref.invalidate(apiKeyProvider);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
