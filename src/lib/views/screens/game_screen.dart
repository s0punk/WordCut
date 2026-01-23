import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/flutter_fit_utils_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';
import 'package:word_cut/utils/theme.dart';
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
  /// Pourcentage de lettres à afficher pour les indices.
  static const double _hintPercentage = 0.5;

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(l10nProvider);
    final gameState = ref.watch(gameStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
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
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (context) => SizedBox(
                  width: double.infinity,
                  child: SafeArea(
                    minimum:
                        FitTheme.of(context).pageMargin?.copyWith(top: 24) ??
                        EdgeInsets.zero,
                    child: Column(
                      children: [
                        FitText.title(strings.settings),
                        const SizedBox(height: 12),
                        ListTile(
                          title: FitText.body(strings.getHint),
                          trailing: FitButton(
                            onTap: () async {
                              final nav = Navigator.of(context);
                              final messenger = ScaffoldMessenger.of(context);

                              final hint = await ref
                                  .read(gameManagerProvider.notifier)
                                  .findCompatibleWord();

                              if (hint == null || !context.mounted) {
                                return;
                              }

                              nav.pop();
                              messenger.showSnackBar(
                                SnackBar(
                                  content: FitText.body(
                                    """${hint.substring(0, (hint.length * _hintPercentage).floor())}...""",
                                  ),
                                ),
                              );
                            },
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: ref.watch(colorSchemeProvider).primary,
                            child: FitText.button(strings.get),
                          ),
                        ),
                      ],
                    ),
                  ),
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
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final word in gameState.words)
              WordInput(
                word: word,
              ),
            if (gameState.words.isNotEmpty)
              WordInput(
                length: gameState.words.last.length - 1,
                enabled: true,
                autoFocus: true,
                onCompleted: (value) async {
                  final result = await ref
                      .read(gameManagerProvider.notifier)
                      .playWord(value);
                },
              ),
          ],
        ),
      ),
    );
  }
}
