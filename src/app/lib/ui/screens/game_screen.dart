import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/flutter_fit_utils_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotspot/hotspot.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/providers/game_mode.dart';
import 'package:word_cut/ui/screens/game_over_screen.dart';
import 'package:word_cut/ui/screens/setting_screen.dart';
import 'package:word_cut/ui/theme.dart';
import 'package:word_cut/ui/widgets/animated_score.dart';
import 'package:word_cut/ui/widgets/countdown.dart';
import 'package:word_cut/ui/widgets/word_input.dart';
import 'package:word_cut/utils/l10n/app_localizations.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';
import 'package:word_cut/utils/tutorial.dart';
import 'package:word_cut/utils/word_play_result.dart';

/// Retourne une route pour aller vers [GameScreen].
///
/// Nécessaire pour wrapper un [HotspotProvider] et afficher les tutoriels.
MaterialPageRoute<void> buildGameScreenRoute(AppLocalizations strings) {
  return MaterialPageRoute<void>(
    builder: (_) => HotspotProvider(
      actionBuilder: (_, controller) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              const SizedBox(width: 8),
              TextButton(
                onPressed: controller.dismiss,
                child: Text(strings.endTour),
              ),
              const Spacer(),
              Transform.translate(
                offset: const Offset(-8, 0),
                child: Row(
                  children: [
                    for (var i = 0; i < controller.pages; i++)
                      AnimatedContainer(
                        margin: const EdgeInsets.all(3),
                        duration: const Duration(milliseconds: 250),
                        decoration: BoxDecoration(
                          color: controller.index == i
                              ? controller.foregroundColor
                              : controller.foregroundColor?.withValues(
                                  alpha: 0.3,
                                ),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        height: 6,
                        width: 6,
                      ),
                  ],
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: controller.next,
                child: AnimatedCrossFade(
                  crossFadeState: controller.index + 1 < controller.pages
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 250),
                  firstChild: Text(strings.next),
                  secondChild: Text(strings.done),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        );
      },
      child: const GameScreen(),
    ),
  );
}

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
  static const Duration scoreAnimationDuration = Duration(seconds: 3);

  final FocusNode wordInputFocusNode = FocusNode();

  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Tutorial.startFlow(context, ref);
    });
  }

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

  void onError(WordPlayResult error) {
    ScaffoldMessenger.of(
        context,
      )
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: FitText(ref.read(wordPlayResultProvider(error)))),
      );

    wordInputFocusNode.requestFocus();
  }

  void onGameOver({String? reason}) {
    ref.read(currentGameStateProvider.notifier).end();

    setState(() {
      gameOver = true;
    });

    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          height: clampDouble(MediaQuery.of(context).size.height * 0.5, 0, 450),
          width: clampDouble(MediaQuery.of(context).size.width * 0.85, 0, 400),
          child: GameOverScreen(reason: reason),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(l10nProvider);

    final gameState = ref.watch(currentGameStateProvider);
    final gameMode = ref.watch(activeGameModeProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          children: [
            FitText.title(
              strings.app,
              style: GoogleFonts.workbench(
                fontSize: 32,
              ),
            ),
            gameMode.maybeWhen(
              data: (gameMode) {
                if (gameMode == GameModes.hard) {
                  return Countdown(
                    start: gameState.startedAt,
                    duration: const Duration(minutes: 2),
                    running: gameState.endedAt == null,
                    onDone: () {
                      if (ref.read(currentGameStateProvider).endedAt == null) {
                        onGameOver(reason: strings.ranOutOfTime);
                      }
                    },
                  );
                }

                return const SizedBox.shrink();
              },
              orElse: () => const SizedBox.shrink(),
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
                showDragHandle: true,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (context) => const SizedBox(
                  width: double.infinity,
                  child: SettingScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ).withHotspot(
            order: 1,
            title: strings.settings,
            text: strings.settingTutorial,
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
                Builder(
                      builder: (context) {
                        if (gameState.words.isEmpty) {
                          return WordInput(
                            key: ValueKey(gameState.words.length),
                            growing: true,
                            enabled: true,
                            autoFocus: true,
                            focusNode: wordInputFocusNode,
                            onCompleted: (value) async {
                              final result = await ref
                                  .read(gameManagerProvider.notifier)
                                  .playCustomFirstWord(value);

                              if (result != WordPlayResult.valid) {
                                onError(result);
                              }
                            },
                          );
                        }

                        if (gameState.words.last.length != 1) {
                          return WordInput(
                            key: ValueKey(
                              gameState.words.last.length - 1,
                            ),
                            length: gameState.words.last.length - 1,
                            enabled: true,
                            autoFocus: true,
                            focusNode: wordInputFocusNode,
                            onCompleted: (value) async {
                              final box =
                                  context.findRenderObject() as RenderBox?;

                              final result = await ref
                                  .read(gameManagerProvider.notifier)
                                  .playWord(value);

                              if (result.status == WordPlayResult.valid) {
                                onScore(result.score, box);

                                if ((await ref
                                        .read(
                                          gameManagerProvider.notifier,
                                        )
                                        .findCompatibleWord(
                                          gameState.words.last,
                                        )) ==
                                    null) {
                                  onGameOver();
                                }
                              } else {
                                onError(result.status);
                              }
                            },
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    )
                    .withHotspot(
                      order: 2,
                      title: strings.play,
                      text: strings.wordInputTutorial,
                    )
                    .withHotspot(
                      flow: Tutorial.flows.last,
                      order: 2,
                      title: strings.play,
                      text: strings.customWordTutorial,
                    ),
                if (gameOver)
                  FitButton(
                    onTap: onGameOver,
                    color: ref.read(colorSchemeProvider).secondary,
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
