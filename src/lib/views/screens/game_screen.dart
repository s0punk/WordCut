import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/flutter_fit_utils_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';
import 'package:word_cut/utils/theme.dart';
import 'package:word_cut/views/screens/game_over_screen.dart';
import 'package:word_cut/views/screens/setting_screen.dart';
import 'package:word_cut/views/widgets/animated_score.dart';
import 'package:word_cut/views/widgets/word_input.dart';

/// Page de jeux de l'app.
/// Permet de saisir les mots, visualiser le score, démarrer une nouvelle partie
/// et accéder aux paramètres.
class GameScreen extends ConsumerStatefulWidget {
  /// Page de jeux de l'app.
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  static const Duration scoreAnimationDuration = Duration(seconds: 3);

  final FocusNode wordInputFocusNode = FocusNode();

  bool gameOver = false;

  void onScore(int score, RenderBox? box) {
    final screenSize = MediaQuery.of(context).size;
    final offset =
        box?.localToGlobal(Offset(box.size.width * 0.8, 0)) ??
        Offset(
          screenSize.width / 2,
          screenSize.height / 2,
        );

    final entry = OverlayEntry(
      builder: (_) => AnimatedScore(
        score: score,
        position: offset,
      ),
    );

    Overlay.of(context).insert(entry);

    Future.delayed(scoreAnimationDuration, entry.remove);
  }

  void onError(int errorCode) {
    final strings = ref.read(l10nProvider);

    final error = switch (errorCode) {
      GameManager.wordNotInList => strings.wordNotInList,
      GameManager.incompatibleWord => strings.wordIncompatible,
      GameManager.wordNotLongEnough => strings.wordNotLongEnough,
      _ => strings.wordRefused,
    };

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: FitText(error)));

    wordInputFocusNode.requestFocus();
  }

  void onGameOver() {
    setState(() {
      gameOver = true;
    });

    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          height: clampDouble(MediaQuery.of(context).size.height * 0.5, 0, 450),
          width: clampDouble(MediaQuery.of(context).size.width * 0.85, 0, 400),
          child: const GameOverScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(l10nProvider);
    final gameState = ref.watch(gameStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: Column(
          children: [
            FitText.title(
              strings.app,
              style: GoogleFonts.workbench(
                fontSize: 32,
              ),
            ),
            FitText.body(
              "${strings.score}: ${gameState.score}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
              margin: const EdgeInsets.only(top: 6),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (context) => const SizedBox(
                  width: double.infinity,
                  child: SettingScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        minimum: FitTheme.of(context).pageMargin ?? EdgeInsets.zero,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final word in gameState.words)
                  WordInput(
                    word: word,
                  ),
                if (gameState.words.isNotEmpty &&
                    gameState.words.last.length != 1)
                  Builder(
                    builder: (context) {
                      return WordInput(
                        key: ValueKey(gameState.words.last.length - 1),
                        length: gameState.words.last.length - 1,
                        enabled: true,
                        autoFocus: true,
                        focusNode: wordInputFocusNode,
                        onCompleted: (value) async {
                          final box = context.findRenderObject() as RenderBox?;

                          final result = await ref
                              .read(gameManagerProvider.notifier)
                              .playWord(value);

                          if (result >= 0) {
                            onScore(result, box);

                            if ((await ref
                                    .read(gameManagerProvider.notifier)
                                    .findCompatibleWord()) ==
                                null) {
                              onGameOver();
                            }
                          } else {
                            onError(result);
                          }
                        },
                      );
                    },
                  ),
                if (gameOver)
                  FitButton(
                    onTap: onGameOver,
                    color: ref.read(colorSchemeProvider).inversePrimary,
                    child: FitText.button(
                      strings.seeResults,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
