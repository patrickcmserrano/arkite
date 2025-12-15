import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:arkite/io/drift_repository.dart';

class GeminiService {
  final String apiKey;
  late final GenerativeModel _model;

  GeminiService({required this.apiKey, String modelId = 'gemini-1.5-pro'}) {
    _model = GenerativeModel(model: modelId, apiKey: apiKey);
  }

  Future<String?> generateContent(String prompt, {List<Node>? history}) async {
    final content = <Content>[];

    // Convert Node history to Gemini Content history
    if (history != null && history.isNotEmpty) {
      for (final node in history) {
        content.add(Content(node.role, [TextPart(node.content)]));
      }
    }

    // Add the current prompt
    content.add(Content.text(prompt));

    final response = await _model.generateContent(content);
    return response.text;
  }

  Stream<GenerateContentResponse> generateContentStream(String prompt) {
    final content = [Content.text(prompt)];
    return _model.generateContentStream(content);
  }
}
