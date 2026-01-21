import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/flutter_fit_utils_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';
import 'package:word_cut/views/widgets/word_input.dart';

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
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        minimum: FitTheme.of(context).pageMargin ?? EdgeInsets.zero,
        child: const Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WordInput(
              word: "MATELAS",
            ),
            WordInput(
              length: 6,
              enabled: true,
            ),
          ],
        ),
      ),
    );
  }
}
