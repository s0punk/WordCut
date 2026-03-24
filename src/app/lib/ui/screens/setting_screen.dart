import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/fit_button.dart';
import 'package:flutter_fit_utils_ui/fit_text.dart';
import 'package:flutter_fit_utils_ui/fit_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/providers/game_mode.dart';
import 'package:word_cut/providers/word_list.dart';
import 'package:word_cut/ui/screens/custom_dictionary_screen.dart';
import 'package:word_cut/ui/screens/welcome_screen.dart';
import 'package:word_cut/ui/theme.dart';
import 'package:word_cut/ui/widgets/game_restart_button.dart';
import 'package:word_cut/utils/l10n/app_localizations.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';

/// Page des paramètres de l'application.
class SettingScreen extends ConsumerWidget {
  /// Pourcentage de lettres à afficher pour les indices.
  static const double _hintPercentage = 0.5;

  /// Page des paramètres de l'application.
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(l10nProvider);
    final trailingWidth = clampDouble(
      MediaQuery.of(context).size.width * 0.35,
      0,
      150,
    );

    final isInGame = ref.watch(currentGameStateProvider).words.isNotEmpty;
    final gameMode = ref.watch(activeGameModeProvider);
    final customWordList = ref.watch(customWordListProvider);

    return SafeArea(
      minimum:
          FitTheme.of(context).pageMargin?.copyWith(top: 24) ?? EdgeInsets.zero,
      child: Column(
        spacing: 24,
        children: [
          FitText.title(strings.settings),
          ListTile(
            title: FitText.body(strings.language),
            trailing: SizedBox(
              width: trailingWidth,
              child: DropdownButtonFormField<Locale>(
                items: [
                  for (final lang in AppLocalizations.supportedLocales)
                    DropdownMenuItem(
                      value: lang,
                      child: FitText.body(
                        ref.read(localeLabelProvider(lang.languageCode)),
                      ),
                    ),
                ],
                initialValue: AppLocalizations.supportedLocales.firstWhere(
                  (l) => l.languageCode == ref.watch(l10nProvider).localeName,
                ),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  ref.read(l10nProvider.notifier).setLocale(value);

                  ref
                    ..invalidate(wordListProvider)
                    ..invalidate(currentGameStateProvider);

                  Navigator.of(context)
                    ..pop()
                    ..pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (_) => const WelcomeScreen(),
                      ),
                    );
                },
                borderRadius: BorderRadius.all(
                  Radius.circular(ref.read(defaultRadiusProvider)),
                ),
              ),
            ),
          ),
          ListTile(
            title: FitText.body(strings.customDictionary),
            subtitle: customWordList != null
                ? FitText.hint(customWordList)
                : null,
            trailing: FitButton(
              onTap: () async {
                showModalBottomSheet<void>(
                  context: context,
                  showDragHandle: true,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => const SizedBox(
                    width: double.infinity,
                    child: CustomWordListScreen(),
                  ),
                );
              },
              width: trailingWidth,
              child: FitText.button(strings.select),
            ),
          ),
          ListTile(
            title: FitText.body(strings.hardMode),
            subtitle: FitText.hint(strings.hardModeDesc),
            trailing: gameMode.maybeWhen(
              data: (gameMode) => Switch(
                value: gameMode == GameModes.hard,
                onChanged: (value) async {
                  ref
                      .read(activeGameModeProvider.notifier)
                      .setGameMode(GameModes.values[value ? 1 : 0]);
                },
              ),
              orElse: () => const CircularProgressIndicator(),
            ),
          ),
          if (isInGame) ...[
            ListTile(
              title: FitText.body(strings.getHint),
              trailing: FitButton(
                onTap: () async {
                  final nav = Navigator.of(context);
                  final messenger = ScaffoldMessenger.of(context);

                  final hint = await ref
                      .read(gameManagerProvider.notifier)
                      .findCompatibleWord(
                        ref.read(currentGameStateProvider).words.last,
                      );

                  if (hint == null || !context.mounted) {
                    return;
                  }

                  nav.pop();
                  messenger.showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FitText.body(
                            """${hint.substring(0, (hint.length * _hintPercentage).floor())}...""",
                          ),
                          TextButton(
                            onPressed: () {
                              messenger
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: FitText.body(hint),
                                  ),
                                );
                            },
                            child: FitText.body(strings.showMore),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                width: trailingWidth,
                color: ref.watch(colorSchemeProvider).primary,
                child: FitText.button(strings.get),
              ),
            ),
            const Spacer(),
            GameRestartButton(
              newGameLabel: strings.newGame,
            ),
          ],
        ],
      ),
    );
  }
}
