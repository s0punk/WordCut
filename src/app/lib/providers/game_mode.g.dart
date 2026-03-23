// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_mode.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeGameModeHash() => r'6b57ddd4938ee9219732d8eaa32e575dd5d19751';

/// Retourne le mode de jeu actif sélectionné par l'utilisateur.
///
/// Copied from [ActiveGameMode].
@ProviderFor(ActiveGameMode)
final activeGameModeProvider =
    AsyncNotifierProvider<ActiveGameMode, GameModes>.internal(
      ActiveGameMode.new,
      name: r'activeGameModeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activeGameModeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ActiveGameMode = AsyncNotifier<GameModes>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
