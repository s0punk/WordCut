import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/fit_button.dart';
import 'package:flutter_fit_utils_ui/fit_text.dart';
import 'package:flutter_fit_utils_ui/fit_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';
import 'package:word_cut/utils/theme.dart';
import 'package:word_cut/views/screens/game_screen.dart';

/// Page d'accueil de l'app.
/// Permet à l'utilisateur de commencer une nouvelle partie.
class WelcomeScreen extends ConsumerWidget {
  /// Page d'accueil de l'app.
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.read(l10nProvider);

    return Scaffold(
      body: SafeArea(
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
              onTap: () {
                ref.read(gameManagerProvider.notifier).resetGame();

                Navigator.of(
                  context,
                ).pushReplacement(
                  MaterialPageRoute<void>(builder: (_) => const GameScreen()),
                );
              },
              color: ref.read(colorSchemeProvider).primary,
              width: double.infinity,
              child: FitText.button(
                strings.play,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
