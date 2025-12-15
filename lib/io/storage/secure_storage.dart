import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();
  static const _apiKeyKey = 'gemini_api_key';
  static const _modelIdKey = 'gemini_model_id';

  Future<void> saveApiKey(String key) async {
    await _storage.write(key: _apiKeyKey, value: key);
  }

  Future<String?> getApiKey() async {
    return await _storage.read(key: _apiKeyKey);
  }

  Future<void> clearApiKey() async {
    await _storage.delete(key: _apiKeyKey);
  }

  Future<void> saveModelId(String id) async {
    await _storage.write(key: _modelIdKey, value: id);
  }

  Future<String> getModelId() async {
    return await _storage.read(key: _modelIdKey) ?? 'gemini-2.5-flash';
  }
}
