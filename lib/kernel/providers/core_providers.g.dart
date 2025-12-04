// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isarRepositoryHash() => r'9369323886f90ffe29addcfe6b6c8a3cd44f7c38';

/// See also [isarRepository].
@ProviderFor(isarRepository)
final isarRepositoryProvider = Provider<IsarRepository>.internal(
  isarRepository,
  name: r'isarRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isarRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsarRepositoryRef = ProviderRef<IsarRepository>;
String _$secureStorageHash() => r'fdcf97f384e865e3e2cf8e4544c72da0d2bda7df';

/// See also [secureStorage].
@ProviderFor(secureStorage)
final secureStorageProvider = Provider<SecureStorage>.internal(
  secureStorage,
  name: r'secureStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$secureStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SecureStorageRef = ProviderRef<SecureStorage>;
String _$apiKeyHash() => r'796c849b44d29fc82b7021682e34f4ee47b149fa';

/// See also [apiKey].
@ProviderFor(apiKey)
final apiKeyProvider = AutoDisposeFutureProvider<String?>.internal(
  apiKey,
  name: r'apiKeyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$apiKeyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ApiKeyRef = AutoDisposeFutureProviderRef<String?>;
String _$geminiServiceHash() => r'5055015008ac628a4bb63a664d54844189ee70eb';

/// See also [geminiService].
@ProviderFor(geminiService)
final geminiServiceProvider = AutoDisposeFutureProvider<GeminiService>.internal(
  geminiService,
  name: r'geminiServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$geminiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GeminiServiceRef = AutoDisposeFutureProviderRef<GeminiService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
