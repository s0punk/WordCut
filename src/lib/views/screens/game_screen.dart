import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/flutter_fit_utils_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';
import 'package:word_cut/utils/theme.dart';
import 'package:word_cut/views/screens/setting_screen.dart';
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
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final word in gameState.words)
              WordInput(
                word: word,
              ),
            if (gameState.words.isNotEmpty && gameState.words.last.length != 1)
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
