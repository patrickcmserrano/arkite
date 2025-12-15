import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:arkite/io/database_tables.dart';

part 'drift_repository.g.dart';

@DriftDatabase(tables: [Projects, Nodes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'arkite_db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
      ),
    );
  }
}

class DriftRepository {
  late AppDatabase _db;

  Future<void> init() async {
    _db = AppDatabase();
  }

  AppDatabase get database => _db;

  // Project operations
  Future<int> saveProject(ProjectsCompanion project) async {
    return await _db
        .into(_db.projects)
        .insert(project, mode: InsertMode.insertOrReplace);
  }

  Future<void> updateProject(ProjectsCompanion project) async {
    await (_db.update(
      _db.projects,
    )..where((tbl) => tbl.id.equals(project.id.value))).write(project);
  }

  Future<void> deleteProject(int projectId) async {
    await _db.transaction(() async {
      // Delete all nodes associated with this project
      await (_db.delete(
        _db.nodes,
      )..where((tbl) => tbl.projectId.equals(projectId))).go();
      // Delete the project
      await (_db.delete(
        _db.projects,
      )..where((tbl) => tbl.id.equals(projectId))).go();
    });
  }

  Stream<List<Project>> watchAllProjects() {
    return (_db.select(_db.projects)..orderBy([
          (tbl) =>
              OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  // Node operations
  Future<int> saveNode(NodesCompanion node) async {
    return await _db
        .into(_db.nodes)
        .insert(node, mode: InsertMode.insertOrReplace);
  }

  Future<Node?> getNode(int id) async {
    return await (_db.select(
      _db.nodes,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// The "Tree Walker"
  /// Reconstructs the conversation history by backtracking from the [headNodeId]
  /// to the root. Returns the list of nodes in chronological order (Root -> Head).
  Future<List<Node>> getHistory(int headNodeId) async {
    final history = <Node>[];
    Node? current = await getNode(headNodeId);

    while (current != null) {
      history.add(current);
      // Load the parent if it exists
      if (current.parentId != null) {
        current = await getNode(current.parentId!);
      } else {
        current = null;
      }
    }

    // Reverse to get chronological order (Root -> Head)
    return history.reversed.toList();
  }

  Future<void> cleanDb() async {
    await _db.transaction(() async {
      await _db.delete(_db.nodes).go();
      await _db.delete(_db.projects).go();
    });
  }

  Future<void> close() async {
    await _db.close();
  }
}
