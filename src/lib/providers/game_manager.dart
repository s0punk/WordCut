import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:word_cut/models/game_state.dart';
import 'package:word_cut/providers/word_list.dart';
import 'package:word_cut/utils/extensions/letter_distribution.dart';
import 'package:word_cut/utils/word_play_result.dart';

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

  /// Termine la partie.
  void end() {
    state = state.copyWith(endedAt: DateTime.now());
  }
}

/// Provider de la gestion de l'état du jeux.
@Riverpod(keepAlive: true)
class GameManager extends _$GameManager {
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
  Future<({WordPlayResult status, int score})> playWord(String word) async {
    debugPrint("INF: Checking $word");

    final gameState = ref.read(currentGameStateProvider);
    final wordList = await ref.read(wordListProvider.future);

    var score = 0;

    if (!wordList.contains(word)) {
      debugPrint("INF: $word not in word list");
      return (status: WordPlayResult.wordNotInList, score: 0);
    }

    if (gameState.words.isNotEmpty) {
      final lastWord = gameState.words.last;
      if ((lastWord.length - word.length).abs() > _maxLetterDiff) {
        return (status: WordPlayResult.wordNotLongEnough, score: 0);
      }

      score += _baseWordScore - (lastWord.length - word.length);

      if (!lastWord.contains(word)) {
        if (_isWordCompatible(lastWord, word)) {
          score += 2;
        } else {
          return (status: WordPlayResult.incompatibleWord, score: 0);
        }
      }
    }

    score *= 100;

    ref.read(currentGameStateProvider.notifier)
      ..incrementScore(score)
      ..addWord(word);

    return (status: WordPlayResult.valid, score: score);
  }

  /// Joue un mot custom de l'utilisateur.
  ///
  /// Le mot doit être le premier de la partie.
  /// Le mot n'a pas besoin d'être dans la liste, mais il doit contenir que des
  /// lettres.
  Future<WordPlayResult> playCustomFirstWord(String word) async {
    if (word.length < _firstWordMinLength) {
      return WordPlayResult.wordNotLongEnough;
    }

    if (RegExp(r"[^\p{L}]", unicode: true).hasMatch(word)) {
      return WordPlayResult.invalidChars;
    }

    ref.read(currentGameStateProvider.notifier).addWord(word);
    return WordPlayResult.valid;
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

    if (addRandomWord) {
      final wordList = await ref.read(wordListProvider.future);
      final possibleWords = wordList.where(
        (x) =>
            x.length >= _firstWordMinLength && x.length <= _firstWordMaxLength,
      );

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
