import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:arkite/kernel/models/node.dart';

class GeminiService {
  final String apiKey;
  late final GenerativeModel _model;

  GeminiService({required this.apiKey, String modelId = 'gemini-1.5-pro'}) {
    _model = GenerativeModel(model: modelId, apiKey: apiKey);
  }

  Future<String?> generateContent(String prompt, {List<Node>? history}) async {
    final content = [Content.text(prompt)];

    // TODO: Convert Node history to Gemini Content history if needed
    // For now, we just send the prompt as a single turn

    final response = await _model.generateContent(content);
    return response.text;
  }

  Stream<GenerateContentResponse> generateContentStream(String prompt) {
    final content = [Content.text(prompt)];
    return _model.generateContentStream(content);
  }
}
