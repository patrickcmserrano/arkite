import 'package:isar/isar.dart';

part 'node.g.dart';

@collection
class Node {
  Id id = Isar.autoIncrement;

  @Index()
  late int projectId;

  // Graph Links
  final parent = IsarLink<Node>();

  // Content
  late String role; // 'user' | 'model'
  late String content; // Markdown text

  // Audit Metadata
  String? modelId; // e.g., 'gemini-1.5-pro'
  double? temperature; // e.g., 0.7
  int? tokenCount;
  int? executionTimeMs; // Telemetry

  late DateTime timestamp;
}
