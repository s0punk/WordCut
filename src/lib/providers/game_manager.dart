import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:word_cut/models/game_state.dart';
import 'package:word_cut/providers/word_list.dart';

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
  static const int _firstWordMinLength = 5;

  @override
  void build() {}

  /// Joue un mot de l'utilisateur.
  /// Vérifie si le mot existe et si les règles du jeux sont respectées.
  Future<void> playWord(String word) async {
    (await ref.read(wordListProvider.future)).contains(word);
  }

  /// Démarre une nouvelle partie.
  Future<void> resetGame() async {
    ref.invalidate(gameStateNotifierProvider);

    final wordList = await ref.read(wordListProvider.future);
    final possibleWords = wordList.where(
      (x) => x.length >= _firstWordMinLength,
    );

    ref
        .read(gameStateNotifierProvider.notifier)
        .addWord(
          possibleWords.elementAt(Random().nextInt(possibleWords.length - 1)),
        );
  }
}
