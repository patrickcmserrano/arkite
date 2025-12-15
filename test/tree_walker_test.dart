import 'package:flutter_test/flutter_test.dart';
import 'package:arkite/io/drift_repository.dart';

import 'package:drift/drift.dart' as drift;

void main() {
  late DriftRepository repo;

  setUp(() async {
    repo = DriftRepository();
    await repo.init();
  });

  tearDown(() async {
    await repo.cleanDb();
  });

  test('Tree Walker reconstructs linear history from graph', () async {
    // 1. Create a Project
    final projectId = await repo.saveProject(
      ProjectsCompanion.insert(
        title: 'Test Project',
        createdAt: DateTime.now(),
      ),
    );

    // 2. Create Root Node (User)
    final rootNodeId = await repo.saveNode(
      NodesCompanion.insert(
        projectId: projectId,
        role: 'user',
        content: 'Hello, who are you?',
        timestamp: DateTime.now(),
      ),
    );

    // 3. Create Child Node (Model)
    final responseNodeId = await repo.saveNode(
      NodesCompanion.insert(
        projectId: projectId,
        parentId: drift.Value(rootNodeId),
        role: 'model',
        content: 'I am a large language model.',
        timestamp: DateTime.now(),
      ),
    );

    // 4. Create Grandchild Node (User)
    final followUpNodeId = await repo.saveNode(
      NodesCompanion.insert(
        projectId: projectId,
        parentId: drift.Value(responseNodeId),
        role: 'user',
        content: 'What can you do?',
        timestamp: DateTime.now(),
      ),
    );

    // 5. Run Tree Walker from the leaf (followUpNode)
    final history = await repo.getHistory(followUpNodeId);

    // 6. Verify
    expect(history.length, 3);
    expect(history[0].content, 'Hello, who are you?');
    expect(history[1].content, 'I am a large language model.');
    expect(history[2].content, 'What can you do?');

    print('Tree Walker Verification Successful!');
    for (var node in history) {
      print('[${node.role}] ${node.content}');
    }
  });
}
