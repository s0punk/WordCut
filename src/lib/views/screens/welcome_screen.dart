import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/fit_button.dart';
import 'package:flutter_fit_utils_ui/fit_loading_handler/fit_loading_handler.dart';
import 'package:flutter_fit_utils_ui/fit_text.dart';
import 'package:flutter_fit_utils_ui/fit_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/providers/word_list.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';
import 'package:word_cut/utils/theme.dart';
import 'package:word_cut/views/screens/game_screen.dart';

/// Page d'accueil de l'app.
/// Permet à l'utilisateur de commencer une nouvelle partie.
class WelcomeScreen extends ConsumerStatefulWidget {
  /// Page d'accueil de l'app.
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool loading = false;

  Future<void> onReset(
    WidgetRef ref,
    BuildContext context, {
    required bool addRandomWord,
  }) async {
    final nav = Navigator.of(context);

    setState(() {
      loading = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Load word list in memory.
      await ref.read(wordListProvider.future);

      ref
          .read(gameManagerProvider.notifier)
          .resetGame(addRandomWord: addRandomWord);

      nav.pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => const GameScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.read(l10nProvider);

    return Scaffold(
      body: FitLoadingHandler(
        loading: loading,
        child: SafeArea(
          minimum: FitTheme.of(context).pageMargin ?? EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              FitText.headline(
                strings.app,
                alignment: Alignment.center,
                style: GoogleFonts.workbench(
                  fontSize: 64,
                ),
              ),
              FitText.title(
                strings.pitch,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              FitButton(
                onTap: () => onReset(ref, context, addRandomWord: true),
                color: ref.read(colorSchemeProvider).primary,
                child: FitText.button(
                  strings.play,
                ),
              ),
              const SizedBox(height: 12),
              FitButton(
                onTap: () => onReset(ref, context, addRandomWord: false),
                color: ref.read(colorSchemeProvider).inversePrimary,
                child: FitText.button(
                  strings.chooseWord,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
