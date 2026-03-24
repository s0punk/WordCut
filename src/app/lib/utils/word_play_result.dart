import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:word_cut/models/game_state.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/providers/word_list.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';

part 'word_play_result.g.dart';

/// Résultats possible de [GameManager.playWord] et
/// [GameManager.playCustomFirstWord].
enum WordPlayResult {
  /// Le mot est valide et a été ajouté au [GameState].
  valid,

  /// Le mot ne figure pas dans [WordList].
  wordNotInList,

  /// Le mot joué ne découle pas du mot précédent.
  incompatibleWord,

  /// Le mot joué n'est pas assez long.
  wordNotLongEnough,

  /// Le mot joué contient un ou plusieurs caractère invalie.
  invalidChars,

  /// Aucun autre mot découle du mot joué.
  noOtherPossibilities,
}

/// Provider des labels des [WordPlayResult].
@riverpod
String wordPlayResult(Ref ref, WordPlayResult result) {
  final strings = ref.read(l10nProvider);

  return switch (result) {
    WordPlayResult.valid => "",
    WordPlayResult.wordNotInList => strings.wordNotInList,
    WordPlayResult.incompatibleWord => strings.wordIncompatible,
    WordPlayResult.wordNotLongEnough => strings.wordNotLongEnough,
    WordPlayResult.invalidChars => strings.invalidChars,
    WordPlayResult.noOtherPossibilities => strings.noOtherPossibleWords,
  };
}
