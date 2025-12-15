class GeminiModel {
  final String id;
  final String name;
  final String description;

  // Token limits
  final int inputTokenLimit;
  final int outputTokenLimit;

  // Supported input types
  final bool supportsText;
  final bool supportsImages;
  final bool supportsVideo;
  final bool supportsAudio;

  // Capabilities
  final bool supportsBatchAPI;
  final bool supportsCaching;
  final bool supportsCodeExecution;
  final bool supportsFileSearch;
  final bool supportsFunctionCalling;
  final bool supportsGroundingWithMaps;
  final bool supportsSearchGrounding;
  final bool supportsStructuredOutputs;
  final bool supportsThinking;
  final bool supportsURLContext;

  // Not supported capabilities
  final bool supportsAudioGeneration;
  final bool supportsImageGeneration;
  final bool supportsLiveAPI;

  // Version information
  final String stableVersion;
  final String? latestUpdate;
  final String? knowledgeCutoff;

  const GeminiModel({
    required this.id,
    required this.name,
    required this.description,
    required this.inputTokenLimit,
    required this.outputTokenLimit,
    this.supportsText = true,
    this.supportsImages = false,
    this.supportsVideo = false,
    this.supportsAudio = false,
    this.supportsBatchAPI = false,
    this.supportsCaching = false,
    this.supportsCodeExecution = false,
    this.supportsFileSearch = false,
    this.supportsFunctionCalling = false,
    this.supportsGroundingWithMaps = false,
    this.supportsSearchGrounding = false,
    this.supportsStructuredOutputs = false,
    this.supportsThinking = false,
    this.supportsURLContext = false,
    this.supportsAudioGeneration = false,
    this.supportsImageGeneration = false,
    this.supportsLiveAPI = false,
    required this.stableVersion,
    this.latestUpdate,
    this.knowledgeCutoff,
  });
}

const List<GeminiModel> availableModels = [
  GeminiModel(
    id: 'gemini-2.5-flash',
    name: 'Gemini 2.5 Flash',
    description:
        'Fast and versatile multimodal model with extensive capabilities.',

    // Token limits
    inputTokenLimit: 1048576, // 1,048,576 tokens
    outputTokenLimit: 65536, // 65,536 tokens
    // Supported input types
    supportsText: true,
    supportsImages: true,
    supportsVideo: true,
    supportsAudio: true,

    // Capabilities
    supportsBatchAPI: true,
    supportsCaching: true,
    supportsCodeExecution: true,
    supportsFileSearch: true,
    supportsFunctionCalling: true,
    supportsGroundingWithMaps: true,
    supportsSearchGrounding: true,
    supportsStructuredOutputs: true,
    supportsThinking: true,
    supportsURLContext: true,

    // Not supported capabilities
    supportsAudioGeneration: false,
    supportsImageGeneration: false,
    supportsLiveAPI: false,

    // Version information
    stableVersion: 'gemini-2.5-flash',
    latestUpdate: 'June 2025',
    knowledgeCutoff: 'January 2025',
  ),
];
