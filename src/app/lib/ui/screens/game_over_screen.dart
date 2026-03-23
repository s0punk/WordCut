import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/fit_text.dart';
import 'package:flutter_fit_utils_ui/fit_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/ui/widgets/game_restart_button.dart';
import 'package:word_cut/utils/extensions/duration.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';

/// Page affichée lorsqu'une partie est terminée.
class GameOverScreen extends ConsumerStatefulWidget {
  /// User-facing string qui indique pourquoi la partie est terminée.
  ///
  /// Si null, trouve automatiquement la raison.
  final String? reason;

  /// Page affichée lorsqu'une partie est terminée.
  const GameOverScreen({super.key, this.reason});

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

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(l10nProvider);
    final gameState = ref.read(currentGameStateProvider);

    final gameOver = gameState.words.last.length > 3;

    final reason =
        widget.reason ??
        (gameState.words.last.length != 1 ? strings.noMorePossibilities : null);

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
              FitText.title(gameOver ? strings.gameOver : strings.congrats),
              if (reason != null)
                FitText.body(
                  reason,
                  textAlign: TextAlign.center,
                ),
              FitText.body(
                "${strings.score}: ${gameState.score}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                margin: const EdgeInsets.only(top: 6),
              ),
              if (gameState.endedAt != null)
                FitText.body(
                  """${strings.solvedIn}: ${gameState.endedAt!.difference(gameState.startedAt).toPrettyString()}""",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  margin: const EdgeInsets.only(top: 6),
                ),
              const Spacer(),
              const GameRestartButton(),
            ],
          );
        },
      ),
    );
  }
}
