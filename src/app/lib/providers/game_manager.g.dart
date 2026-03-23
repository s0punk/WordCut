// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentGameStateHash() => r'9d1d6fd747253891d8943597583de7efde856e9c';

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
String _$gameManagerHash() => r'f54902ab08ba4372de77dbb350d486e018a85d85';

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
