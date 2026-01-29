import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/fit_button.dart';
import 'package:flutter_fit_utils_ui/fit_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';
import 'package:word_cut/utils/theme.dart';
import 'package:word_cut/views/screens/game_screen.dart';

/// Widget qui permet de commencer une partie avec ou sans mot custom.
class GameRestartButton extends ConsumerWidget {
  /// Appelé lorsque l'utilisateur démarre une partie.
  ///
  /// Si ```null```, le flow de démarrage par défaut est effectué
  /// automatiquement.
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool customGame)? onNewGame;

  /// Label du bouton pour démarrer une partie normale.
  final String? newGameLabel;

  /// Label du bouton pour démarrer une partie avec un mot personnalisé.
  final String? newCustomGameLabel;

  /// Widget qui permet de commencer une partie avec ou sans mot custom.
  const GameRestartButton({
    this.onNewGame,
    this.newGameLabel,
    this.newCustomGameLabel,
    super.key,
  });

  void _onReset(
    WidgetRef ref,
    BuildContext context, {
    required bool customGame,
  }) {
    ref.read(gameManagerProvider.notifier).resetGame(addRandomWord: customGame);

    Navigator.of(
        context,
      )
      ..pop()
      ..pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => const GameScreen(),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(l10nProvider);

    final newGameLabel = this.newGameLabel ?? strings.playAgain;
    final newCustomGameLabel = this.newCustomGameLabel ?? strings.chooseWord;

    return Column(
      spacing: 12,
      children: [
        FitButton(
          onTap: () {
            if (onNewGame != null) {
              onNewGame!(true);
              return;
            }

            _onReset(ref, context, customGame: true);
          },
          color: ref.read(colorSchemeProvider).primary,
          child: FitText.button(
            newGameLabel,
          ),
        ),
        FitButton(
          onTap: () {
            if (onNewGame != null) {
              onNewGame!(false);
              return;
            }

            _onReset(ref, context, customGame: false);
          },
          color: ref.read(colorSchemeProvider).inversePrimary,
          child: FitText.button(
            newCustomGameLabel,
          ),
        ),
      ],
    );
  }
}
