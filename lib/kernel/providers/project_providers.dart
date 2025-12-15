import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart' as drift;
import 'package:arkite/io/drift_repository.dart';
import 'package:arkite/kernel/providers/core_providers.dart';

part 'project_providers.g.dart';

@riverpod
Stream<List<Project>> projectList(ProjectListRef ref) {
  final repo = ref.watch(driftRepositoryProvider);
  return repo.watchAllProjects();
}

@riverpod
class ProjectManager extends _$ProjectManager {
  @override
  FutureOr<void> build() {}

  Future<void> createProject(String title, {String? systemInstruction}) async {
    final repo = ref.read(driftRepositoryProvider);
    final companion = ProjectsCompanion(
      title: drift.Value(title),
      globalSystemInstruction: drift.Value(systemInstruction),
      createdAt: drift.Value(DateTime.now()),
    );

    await repo.saveProject(companion);
  }

  Future<void> deleteProject(int projectId) async {
    final repo = ref.read(driftRepositoryProvider);
    await repo.deleteProject(projectId);
  }

  Future<void> updateProject(
    int id,
    String title, {
    String? systemInstruction,
  }) async {
    final repo = ref.read(driftRepositoryProvider);
    final companion = ProjectsCompanion(
      id: drift.Value(id),
      title: drift.Value(title),
      globalSystemInstruction: drift.Value(systemInstruction),
    );
    await repo.updateProject(companion);
  }
}
