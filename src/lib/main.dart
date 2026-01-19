import 'package:flutter/material.dart';
import 'package:word_cut/utils/l10n/app_localizations.dart';
import 'package:word_cut/views/screens/game_screen.dart';

void main() {
  runApp(const WordCut());
}

/// Widget principal de l'application.
class WordCut extends StatelessWidget {
  /// Widget principal de l'application.
  const WordCut({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      restorationScopeId: "word_cut",
      title: "WordCut",
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
