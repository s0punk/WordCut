import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';

part 'word_list.g.dart';

/// Provider de la liste de mot selon la langue utilisé.
@Riverpod(keepAlive: true)
Future<Set<String>> wordList(Ref ref) async {
  try {
    final locale = ref.watch(l10nProvider).localeName;

    final list = await rootBundle.loadString(
      "assets/word_lists/$locale.txt",
    );

    final set = list.split("\n").toSet();
    debugPrint(
      "INF: Loaded ${set.length} words ${locale.toUpperCase()} from word list",
    );

    return set;
  } on Exception {
    debugPrint("WRN: Word list is inaccessible!");
  }

  return <String>{};
}
