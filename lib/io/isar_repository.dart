import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:arkite/kernel/models/node.dart';
import 'package:arkite/kernel/models/project.dart';

class IsarRepository {
  late Isar _isar;

  Future<void> init({String? directory}) async {
    final dirPath =
        directory ?? (await getApplicationDocumentsDirectory()).path;
    _isar = await Isar.open([ProjectSchema, NodeSchema], directory: dirPath);
  }

  Future<void> saveProject(Project project) async {
    await _isar.writeTxn(() async {
      await _isar.projects.put(project);
    });
  }

  Future<void> saveNode(Node node) async {
    await _isar.writeTxn(() async {
      await _isar.nodes.put(node);
      await node.parent.save();
    });
  }

  Future<Node?> getNode(Id id) async {
    return await _isar.nodes.get(id);
  }

  /// The "Tree Walker"
  /// Reconstructs the conversation history by backtracking from the [headNodeId]
  /// to the root. Returns the list of nodes in chronological order (Root -> Head).
  Future<List<Node>> getHistory(Id headNodeId) async {
    final history = <Node>[];
    Node? current = await _isar.nodes.get(headNodeId);

    while (current != null) {
      history.add(current);
      // Load the parent
      await current.parent.load();
      current = current.parent.value;
    }

    // Reverse to get chronological order (Root -> Head)
    return history.reversed.toList();
  }

  Future<void> cleanDb() async {
    await _isar.writeTxn(() async {
      await _isar.clear();
    });
  }
}
