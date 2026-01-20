// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameStateNotifierHash() => r'a665c380de24888350b61553210ec394c8d8f722';

/// Provider de l'état actif du jeux.
///
/// Copied from [GameStateNotifier].
@ProviderFor(GameStateNotifier)
final gameStateNotifierProvider =
    NotifierProvider<GameStateNotifier, GameState>.internal(
      GameStateNotifier.new,
      name: r'gameStateNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$gameStateNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GameStateNotifier = Notifier<GameState>;
String _$gameManagerHash() => r'f1bdc9173f89688bc9e50938d8dcb6ffc313558b';

/// Provider de la gestion de l'état du jeux.
///
/// Copied from [GameManager].
@ProviderFor(GameManager)
final gameManagerProvider = NotifierProvider<GameManager, void>.internal(
  GameManager.new,
  name: r'gameManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GameManager = Notifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
