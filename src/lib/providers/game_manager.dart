import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:word_cut/models/game_state.dart';
import 'package:word_cut/providers/word_list.dart';
import 'package:word_cut/utils/extensions/letter_distribution.dart';

part 'game_manager.g.dart';

/// Provider de l'état actif du jeux.
@Riverpod(keepAlive: true)
class CurrentGameState extends _$CurrentGameState {
  @override
  GameState build() => GameState(words: [], startedAt: DateTime.now());

  /// Incrémente le score de la partie de [score].
  void incrementScore(int score) {
    state = state.copyWith(score: state.score + score);
  }

  /// Ajoute un nouveau mot à la liste de mot joué.
  void addWord(String word) {
    state.words.add(word);
    ref.notifyListeners();

    debugPrint("INF: Added $word to stack");
  }
}

/// Provider de la gestion de l'état du jeux.
@Riverpod(keepAlive: true)
class GameManager extends _$GameManager {
  /// Code d'erreur qui indique que le mot joué ne fait pas partie de la liste.
  static const int wordNotInList = -1;

  /// Code d'erreur qui indique que le mot joué ne découle pas du mot précédent.
  static const int incompatibleWord = -2;

  /// Code d'erreur qui indique que le mot joué n'est pas assez long.
  static const int wordNotLongEnough = -3;

  static const int _firstWordMinLength = 5;
  static const int _firstWordMaxLength = 12;

  /// Différence maximale entre la longeur du dernier mot joué et le prochain.
  static const int _maxLetterDiff = 3;

  /// Score de base pour un mot joué.
  /// Ce score de base est réduit selon le nombre de lettre retirées depuis le
  /// dernier mot joué.
  static const int _baseWordScore = 4;

  @override
  void build() {}

  /// Joue un mot de l'utilisateur.
  /// Vérifie si le mot existe et si les règles du jeux sont respectées.
  ///
  /// Retourne le score obtenue avec le mot joué.
  /// Si le score est -1, le mot n'est pas dans la liste.
  /// Si le score est -2, le mot n'est pas compatible avec le précédent.
  /// Si le score est -3, le mot n'est pas assez long.
  Future<int> playWord(String word) async {
    debugPrint("INF: Checking $word");

    final gameState = ref.read(currentGameStateProvider);
    final wordList = await ref.read(wordListProvider.future);

    var score = 0;

    if (!wordList.contains(word)) {
      debugPrint("INF: $word not in word list");
      return wordNotInList;
    }

    if (gameState.words.isNotEmpty) {
      final lastWord = gameState.words.last;
      if ((lastWord.length - word.length).abs() > _maxLetterDiff) {
        return wordNotLongEnough;
      }

      score += _baseWordScore - (lastWord.length - word.length);

      if (!lastWord.contains(word)) {
        if (_isWordCompatible(lastWord, word)) {
          score += 2;
        } else {
          return incompatibleWord;
        }
      }
    }

    score *= 100;

    ref.read(currentGameStateProvider.notifier)
      ..incrementScore(score)
      ..addWord(word);

    return score;
  }

  /// Vérifie s'il est possible de continuer la partie.
  /// Il n'est pas possible de continuer la partie s'il ne reste plus de mot
  /// possible selon les lettres disponibles et le nombre de lettres restant.
  ///
  /// Si la partie peut être continuée, retourne un mot possible.
  /// Si la partie ne peut pas être continuée, retourne null.
  Future<String?> findCompatibleWord() async {
    final gameState = ref.read(currentGameStateProvider);
    if (gameState.words.isEmpty) {
      return null;
    }

    final lastWord = gameState.words.last;
    final wordList = await ref.read(wordListProvider.future);

    if (lastWord.length == 1) {
      return null;
    }

    final possibleWords = wordList.where(
      (e) =>
          e.length >= (lastWord.length - _maxLetterDiff) &&
          e.length <= (lastWord.length - 1) &&
          _isWordCompatible(lastWord, e),
    );

    if (possibleWords.isEmpty) {
      return null;
    }

    if (possibleWords.length == 1) {
      return possibleWords.elementAt(0);
    }

    // Retourner un élément au hasard pour le système d'indice.
    return possibleWords.elementAt(Random().nextInt(possibleWords.length - 1));
  }

  /// Démarre une nouvelle partie.
  Future<void> resetGame({bool addRandomWord = true}) async {
    ref.invalidate(currentGameStateProvider);

    final wordList = await ref.read(wordListProvider.future);
    final possibleWords = wordList.where(
      (x) => x.length >= _firstWordMinLength && x.length <= _firstWordMaxLength,
    );

    if (addRandomWord) {
      ref
          .read(currentGameStateProvider.notifier)
          .addWord(
            possibleWords.elementAt(Random().nextInt(possibleWords.length - 1)),
          );
    }
  }

  bool _isWordCompatible(String lastWord, String word) {
    if (word.length >= lastWord.length) {
      return false;
    }

    final oldDistribution = lastWord.getLetterDistribution();
    final newDistribution = word.getLetterDistribution();

    var differences = 0;
    for (final e in oldDistribution.entries) {
      differences += (e.value - (newDistribution[e.key] ?? 0)).abs();
    }

    if (differences != lastWord.length - word.length) {
      // Trop de lettre différente, le nouveau ne découle pas du précédent.
      return false;
    }

    return true;
  }
}
