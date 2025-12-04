import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:arkite/io/isar_repository.dart';
import 'package:arkite/kernel/models/node.dart';
import 'package:arkite/kernel/models/project.dart';
import 'package:isar/isar.dart';

void main() {
  late IsarRepository repo;
  late Directory tempDir;

  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    tempDir = await Directory.systemTemp.createTemp('isar_test');
    repo = IsarRepository();
    await repo.init(directory: tempDir.path);
  });

  tearDown(() async {
    await repo.cleanDb();
    // Close isar instance if possible or just let it be for now
  });

  test('Tree Walker reconstructs linear history from graph', () async {
    // 1. Create a Project
    final project = Project()
      ..title = 'Test Project'
      ..createdAt = DateTime.now();
    await repo.saveProject(project);

    // 2. Create Root Node (User)
    final rootNode = Node()
      ..projectId = project.id
      ..role = 'user'
      ..content = 'Hello, who are you?'
      ..timestamp = DateTime.now();
    await repo.saveNode(rootNode);

    // 3. Create Child Node (Model)
    final responseNode = Node()
      ..projectId = project.id
      ..role = 'model'
      ..content = 'I am a large language model.'
      ..timestamp = DateTime.now();
    responseNode.parent.value = rootNode;
    await repo.saveNode(responseNode);

    // 4. Create Grandchild Node (User)
    final followUpNode = Node()
      ..projectId = project.id
      ..role = 'user'
      ..content = 'What can you do?'
      ..timestamp = DateTime.now();
    followUpNode.parent.value = responseNode;
    await repo.saveNode(followUpNode);

    // 5. Run Tree Walker from the leaf (followUpNode)
    final history = await repo.getHistory(followUpNode.id);

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
