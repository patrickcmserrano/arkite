import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:arkite/io/drift_repository.dart';
import 'package:arkite/io/storage/secure_storage.dart';
import 'package:arkite/kernel/services/gemini_service.dart';

part 'core_providers.g.dart';

@Riverpod(keepAlive: true)
DriftRepository driftRepository(DriftRepositoryRef ref) {
  throw UnimplementedError(
    'driftRepositoryProvider must be overridden in main.dart',
  );
}

@Riverpod(keepAlive: true)
SecureStorage secureStorage(SecureStorageRef ref) {
  return SecureStorage();
}

@riverpod
Future<String?> apiKey(ApiKeyRef ref) async {
  final storage = ref.watch(secureStorageProvider);
  return await storage.getApiKey();
}

@riverpod
Future<GeminiService> geminiService(GeminiServiceRef ref) async {
  final apiKey = await ref.watch(apiKeyProvider.future);
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('API Key not found');
  }
  return GeminiService(apiKey: apiKey);
}
