import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/flutter_fit_utils_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';

/// Page de jeux de l'app.
///
/// Permet de saisir les mots, visualiser le score, démarrer une nouvelle partie
/// et accéder aux paramètres.
class GameScreen extends ConsumerStatefulWidget {
  /// Page de jeux de l'app.
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(l10nProvider);
    final gameState = ref.watch(gameStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: FitText.title(strings.app),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: SafeArea(
        minimum: FitTheme.of(context).pageMargin ?? EdgeInsets.zero,
        child: Column(
          spacing: 12,
          children: [
            FitButton(
              onTap: () {
                ref.read(gameStateNotifierProvider.notifier).incrementScore(10);
              },
              child: const FitText.button("Add score"),
            ),
            FitButton(
              onTap: () {
                ref.read(gameStateNotifierProvider.notifier).addWord("Hey!");
              },
              child: const FitText.button("Add word"),
            ),
            FitButton(
              onTap: () {
                ref.read(gameManagerProvider.notifier).resetGame();
              },
              child: const FitText.button("Reset game"),
            ),
            FitButton(
              onTap: () {
                ref.read(gameManagerProvider.notifier).resetGame();
              },
              child: const FitText.button("Reset game"),
            ),
            FitButton(
              onTap: () async {
                await ref.read(gameManagerProvider.notifier).playWord("");
              },
              child: const FitText.button("Play a word"),
            ),
            Text(ref.read(l10nProvider).localeName),
            Text("Score ${gameState.score}"),
            for (final word in gameState.words) Text(word),
          ],
        ),
      ),
    );
  }
}
