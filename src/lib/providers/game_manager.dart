import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:word_cut/models/game_state.dart';

part 'game_manager.g.dart';

/// Provider de l'état actif du jeux.
@Riverpod(keepAlive: true)
class GameStateNotifier extends _$GameStateNotifier {
  @override
  GameState build() => GameState(words: []);

  /// Incrémente le score de la partie de [score].
  void incrementScore(int score) {
    state = state.copyWith(score: state.score + score);
  }

  /// Ajoute un nouveau mot à la liste de mot joué.
  void addWord(String word) {
    state.words.add(word);
    ref.notifyListeners();
  }
}

/// Provider de la gestion de l'état du jeux.
@Riverpod(keepAlive: true)
class GameManager extends _$GameManager {
  @override
  void build() {}

  /// Démarre une nouvelle partie.
  void resetGame() {
    ref.invalidate(gameStateNotifierProvider);
  }
}
