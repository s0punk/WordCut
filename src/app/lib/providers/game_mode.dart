import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:word_cut/utils/preferences.dart';
import 'package:word_cut/utils/shared_preferences.dart';

part 'game_mode.g.dart';

/// Modes de jeu.
enum GameModes {
  /// Jeu classique.
  classic,

  /// Mode difficile.
  ///
  /// Impose une limite de temps et des mots de départ plus long.
  hard,
}

/// Retourne le mode de jeu actif sélectionné par l'utilisateur.
@Riverpod(keepAlive: true)
class ActiveGameMode extends _$ActiveGameMode {
  @override
  Future<GameModes> build() async {
    final gameModeIndex =
        await ref.read(preferencesProvider).getInt(Preferences.gameMode) ?? 0;

    return GameModes.values[gameModeIndex];
  }

  /// Change le mode de jeu.
  ///
  /// Enregistre le mode de jeu dans les préférences de l'utilisateur.
  /// [gameMode] sera choisit par défaut.
  Future<void> setGameMode(GameModes gameMode) async {
    state = AsyncData(gameMode);

    return ref
        .read(preferencesProvider)
        .setInt(Preferences.gameMode, gameMode.index);
  }
}
