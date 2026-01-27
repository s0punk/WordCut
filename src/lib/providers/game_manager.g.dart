// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentGameStateHash() => r'6ffbca3a07d4881df7c153b58ee69097696763a1';

/// Provider de l'état actif du jeux.
///
/// Copied from [CurrentGameState].
@ProviderFor(CurrentGameState)
final currentGameStateProvider =
    NotifierProvider<CurrentGameState, GameState>.internal(
      CurrentGameState.new,
      name: r'currentGameStateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentGameStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentGameState = Notifier<GameState>;
String _$gameManagerHash() => r'a2ef9e769efd8044ee0de621e3656fd449b560f5';

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
