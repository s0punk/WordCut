import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/fit_button.dart';
import 'package:flutter_fit_utils_ui/fit_text.dart';
import 'package:flutter_fit_utils_ui/fit_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';
import 'package:word_cut/utils/theme.dart';
import 'package:word_cut/views/screens/game_screen.dart';

/// Page affichée lorsqu'une partie est terminée.
class GameOverScreen extends ConsumerStatefulWidget {
  /// Page affichée lorsqu'une partie est terminée.
  const GameOverScreen({super.key});

  @override
  ConsumerState<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends ConsumerState<GameOverScreen> {
  late final Future<LottieComposition> lottieAnimation;

  @override
  void initState() {
    super.initState();
    lottieAnimation = AssetLottie("assets/lottie/trophie.json").load();
  }

  void onReset({required bool addRandomWord}) {
    ref
        .read(gameManagerProvider.notifier)
        .resetGame(addRandomWord: addRandomWord);

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
  Widget build(BuildContext context) {
    final strings = ref.watch(l10nProvider);
    final gameState = ref.read(gameStateNotifierProvider);

    final title = gameState.words.last.length <= 3
        ? strings.congrats
        : strings.gameOver;

    // TODO(s0punk): Show special message if game ended because no possible solutions (game lost).
    // TODO(s0punk): Add time used to solve.

    return SafeArea(
      minimum:
          FitTheme.of(context).pageMargin?.copyWith(bottom: 24) ??
          EdgeInsets.zero,
      child: FutureBuilder(
        future: lottieAnimation,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  Align(
                    child: Lottie(
                      composition: snapshot.data,
                      repeat: false,
                      height: 150,
                    ),
                  ),
                ],
              ),
              FitText.title(title),
              FitText.body(
                "${strings.score}: ${gameState.score}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                margin: const EdgeInsets.only(top: 6),
              ),
              const Spacer(),
              FitButton(
                onTap: () => onReset(addRandomWord: true),
                color: ref.read(colorSchemeProvider).primary,
                child: FitText.button(
                  strings.playAgain,
                ),
              ),
              const SizedBox(height: 12),
              FitButton(
                onTap: () => onReset(addRandomWord: false),
                color: ref.read(colorSchemeProvider).inversePrimary,
                child: FitText.button(
                  strings.chooseWord,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
