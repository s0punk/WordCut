import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/fit_loading_handler/fit_loading_handler.dart';
import 'package:flutter_fit_utils_ui/fit_text.dart';
import 'package:flutter_fit_utils_ui/fit_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/providers/word_list.dart';
import 'package:word_cut/ui/screens/game_screen.dart';
import 'package:word_cut/ui/screens/setting_screen.dart';
import 'package:word_cut/ui/widgets/game_restart_button.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';

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
    final strings = ref.read(l10nProvider);

    setState(() {
      loading = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Load word list in memory.
      await ref.read(wordListProvider.future);

      ref
          .read(gameManagerProvider.notifier)
          .resetGame(addRandomWord: addRandomWord);

      nav.pushReplacement(buildGameScreenRoute(strings));
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.read(l10nProvider);

    return Scaffold(
      appBar: AppBar(
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
          ),
        ],
      ),
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
              GameRestartButton(
                newGameLabel: strings.play,
                onNewGame: (customGame) =>
                    onReset(ref, context, addRandomWord: customGame),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
