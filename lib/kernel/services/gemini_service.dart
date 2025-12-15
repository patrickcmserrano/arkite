import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:arkite/io/drift_repository.dart';
import 'dart:developer' as developer;

class GeminiService {
  final String apiKey;
  late final GenerativeModel _model;

  GeminiService({required this.apiKey, String modelId = 'gemini-2.5-flash'}) {
    developer.log('🔧 Initializing GeminiService', name: 'GeminiService');
    developer.log('📋 Model ID: $modelId', name: 'GeminiService');
    developer.log(
      '🔑 API Key present: ${apiKey.isNotEmpty}',
      name: 'GeminiService',
    );
    developer.log('🔑 API Key length: ${apiKey.length}', name: 'GeminiService');
    developer.log(
      '🔑 API Key prefix: ${apiKey.substring(0, apiKey.length > 10 ? 10 : apiKey.length)}...',
      name: 'GeminiService',
    );

    _model = GenerativeModel(model: modelId, apiKey: apiKey);
    developer.log(
      '✅ GenerativeModel created successfully',
      name: 'GeminiService',
    );
  }

  Future<String?> generateContent(String prompt, {List<Node>? history}) async {
    developer.log('📤 Starting generateContent request', name: 'GeminiService');
    developer.log('📝 Prompt length: ${prompt.length}', name: 'GeminiService');
    developer.log(
      '📚 History items: ${history?.length ?? 0}',
      name: 'GeminiService',
    );

    try {
      final content = <Content>[];

      // Convert Node history to Gemini Content history
      if (history != null && history.isNotEmpty) {
        developer.log(
          '🔄 Converting ${history.length} history items',
          name: 'GeminiService',
        );
        for (final node in history) {
          content.add(Content(node.role, [TextPart(node.content)]));
        }
      }

      // Add the current prompt
      content.add(Content.text(prompt));

      developer.log(
        '📦 Total content items: ${content.length}',
        name: 'GeminiService',
      );
      developer.log(
        '🚀 Sending request to Gemini API...',
        name: 'GeminiService',
      );

      final response = await _model.generateContent(content);

      developer.log('✅ Response received successfully', name: 'GeminiService');
      developer.log(
        '📥 Response text length: ${response.text?.length ?? 0}',
        name: 'GeminiService',
      );

      return response.text;
    } catch (e, stackTrace) {
      developer.log(
        '❌ Error in generateContent',
        name: 'GeminiService',
        error: e,
        stackTrace: stackTrace,
      );
      developer.log('🔍 Error type: ${e.runtimeType}', name: 'GeminiService');
      developer.log('🔍 Error details: $e', name: 'GeminiService');
      rethrow;
    }
  }

  Stream<GenerateContentResponse> generateContentStream(String prompt) {
    developer.log(
      '📤 Starting generateContentStream request',
      name: 'GeminiService',
    );
    final content = [Content.text(prompt)];
    return _model.generateContentStream(content);
  }
}
