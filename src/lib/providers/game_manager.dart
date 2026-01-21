import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:word_cut/models/game_state.dart';
import 'package:word_cut/providers/word_list.dart';
import 'package:word_cut/utils/extensions/letter_distribution.dart';

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

    debugPrint("INF: Added $word to stack");
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
  /// Si le score est -1, le mot est refusé et ne peut pas être joué.
  Future<int> playWord(String word) async {
    debugPrint("INF: Checking $word");

    final gameState = ref.read(gameStateNotifierProvider);
    final wordList = await ref.read(wordListProvider.future);

    var score = 0;

    if (!wordList.contains(word)) {
      debugPrint("INF: $word not in word list");
      return -1;
    }

    if (gameState.words.isEmpty) {
      return -1;
    }

    final lastWord = gameState.words.last;
    if (lastWord.length >= word.length ||
        (lastWord.length - word.length) > _maxLetterDiff) {
      return -1;
    }

    score += _baseWordScore - (lastWord.length - word.length);

    if (!lastWord.contains(word)) {
      if (_isWordCompatible(lastWord, word)) {
        score += 2;
      } else {
        return -1;
      }
    }

    ref.read(gameStateNotifierProvider.notifier)
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
    final gameState = ref.read(gameStateNotifierProvider);
    if (gameState.words.isEmpty) {
      return null;
    }

    final lastWord = gameState.words.last;
    final wordList = await ref.read(wordListProvider.future);

    final possibleWords = wordList.where(
      (e) =>
          e.length >= (lastWord.length - _maxLetterDiff) &&
          e.length <= (lastWord.length - 1),
    );

    if (possibleWords.isEmpty) {
      return null;
    }

    if (!possibleWords.any((e) => _isWordCompatible(lastWord, e))) {
      return null;
    }

    return possibleWords.first;
  }

  /// Démarre une nouvelle partie.
  Future<void> resetGame() async {
    ref.invalidate(gameStateNotifierProvider);

    final wordList = await ref.read(wordListProvider.future);
    final possibleWords = wordList.where(
      (x) => x.length >= _firstWordMinLength && x.length <= _firstWordMaxLength,
    );

    ref
        .read(gameStateNotifierProvider.notifier)
        .addWord(
          possibleWords
              .elementAt(Random().nextInt(possibleWords.length - 1))
              .toUpperCase(),
        );
  }

  bool _isWordCompatible(String lastWord, String word) {
    final oldDistribution = lastWord.getLetterDistribution();
    final newDistribution = word.getLetterDistribution();

    var differences = 0;
    for (final e in oldDistribution.entries) {
      differences += e.value - (newDistribution[e.key] ?? 0);
    }

    if (differences > lastWord.length - word.length) {
      // Trop de lettre différente, le nouveau ne découle pas du précédent.
      return false;
    }

    // Vérifier que le nouveau mot ne contient une lettre qui n'est pas dans
    // le mot précédent.
    if (newDistribution.entries.any((e) => oldDistribution[e.key] == null)) {
      return false;
    }

    return true;
  }
}
