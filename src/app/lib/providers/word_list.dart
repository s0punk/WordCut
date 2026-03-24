import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';
import 'package:word_cut/utils/preferences.dart';
import 'package:word_cut/utils/shared_preferences.dart';

part 'word_list.g.dart';

/// Provider qui indique si [WordList] utilise un dictionnaire personnalisé
/// fournit par l'utilisateur.
///
/// Retourne le nom du dictionnaire personnalisé, sinon null.
final customWordListProvider = StateProvider<String?>((ref) => null);

/// Provider de la liste de mot selon la langue utilisé.
@Riverpod(keepAlive: true)
class WordList extends _$WordList {
  static const String _customWordListFile = "custom_word_list.txt";

  @override
  Future<Set<String>> build() async {
    final customWordList = await _readCustomWordList();
    if (customWordList != null) {
      return customWordList;
    }

    final locale = ref.watch(l10nProvider).localeName;

    try {
      final rawList = await rootBundle.loadString(
        "assets/word_lists/$locale.txt",
      );

      final set = await _extractList(rawList);

      debugPrint(
        """INF: Loaded ${set.length} words ${locale.toUpperCase()} from word list""",
      );

      return set;
    } on Exception {
      debugPrint("WRN: Word list is inaccessible!");
    }

    return <String>{};
  }

  Future<Set<String>> _extractList(String rawList) =>
      compute<String, Set<String>>(
        (list) => list.replaceAll("\r\n", "\n").split("\n").toSet(),
        rawList,
      );

  /// Lit le dictionnaire personnalisé enregistré localement.
  ///
  /// Retourne null si aucun dictionnaire personnalisé n'a été enregistré.
  Future<Set<String>?> _readCustomWordList() async {
    final customWordList = await ref
        .read(preferencesProvider)
        .getString(Preferences.customWordList);

    if (customWordList == null) {
      return null;
    }

    try {
      final appDir = await getApplicationDocumentsDirectory();
      final wordListFile = File("${appDir.path}/$_customWordListFile");

      final content = await wordListFile.readAsString();
      final list = await _extractList(content);

      ref.read(customWordListProvider.notifier).state = customWordList;

      return list;
    } on Exception {
      return null;
    }
  }

  /// Set le dictionnaire custom à utiliser.
  ///
  /// Retourne true si le contenu du dictionnaire est valide est peut être
  /// utilisé par l'application.
  Future<bool> setCustomWordList(String name, String content) async {
    // Format invalide (json, xml, etc).
    if (content.contains(RegExp(r"[{}<>\/\[\]:,.;]+"))) {
      return false;
    }

    try {
      final appDir = await getApplicationDocumentsDirectory();

      final wordListFile = await File(
        "${appDir.path}/$_customWordListFile",
      ).create(recursive: true);

      await wordListFile.writeAsString(content);
    } on Exception {
      return false;
    }

    await ref
        .read(preferencesProvider)
        .setString(Preferences.customWordList, name);

    state = AsyncData(await _extractList(content));
    ref.read(customWordListProvider.notifier).state = name;

    return true;
  }
}
