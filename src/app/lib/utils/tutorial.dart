import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotspot/hotspot.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:word_cut/utils/shared_preferences.dart';

part 'tutorial.g.dart';

/// Gère les tutoriels de l'application.
@riverpod
class Tutorial extends _$Tutorial {
  /// Liste des différents flow de tutoriel.
  static const List<String> flows = [
    "main", // Flow principal: settings, jeu de base.
  ];

  @override
  Future<List<String>> build() async {
    final tutorials = List<String>.from(flows);

    for (final tutorial in flows) {
      // Ne pas afficher le flow s'il a déjà été vu.
      if (await ref.read(preferencesProvider).getBool(tutorial) ?? false) {
        tutorials.remove(tutorial);
      }
    }

    return tutorials;
  }

  /// Marque [flow] comme étant vu ou non.
  Future<void> markAs(String flow, {required bool seen}) async {
    if (!flows.contains(flow)) {
      return;
    }

    await ref.read(preferencesProvider).setBool(flow, seen);

    if (!state.hasValue) {
      return;
    }

    if (seen) {
      state.value!.remove(flow);
    } else {
      state.value!.add(flow);
    }
  }

  /// Marque tous les flows comme étant non-vu.
  Future<void> reset() async {
    for (final tutorial in flows) {
      await markAs(tutorial, seen: false);
    }
  }

  /// Démarre un flow.
  static Future<void> startFlow(BuildContext context, WidgetRef ref) async {
    final hotspot = HotspotProvider.of(context);
    final tutorials = await ref.read(tutorialProvider.future);

    if (tutorials.isNotEmpty) {
      hotspot.startFlow(tutorials.first);
      ref.read(tutorialProvider.notifier).markAs(tutorials.first, seen: true);
    }
  }
}
