// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectListHash() => r'4c644bf610972e38eeb012d09823c518d77f95cf';

/// See also [projectList].
@ProviderFor(projectList)
final projectListProvider = AutoDisposeStreamProvider<List<Project>>.internal(
  projectList,
  name: r'projectListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$projectListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProjectListRef = AutoDisposeStreamProviderRef<List<Project>>;
String _$projectManagerHash() => r'fd072ff41086c4b14f1d3f2b06fff478bcf4cbdf';

/// See also [ProjectManager].
@ProviderFor(ProjectManager)
final projectManagerProvider =
    AutoDisposeAsyncNotifierProvider<ProjectManager, void>.internal(
      ProjectManager.new,
      name: r'projectManagerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$projectManagerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProjectManager = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
