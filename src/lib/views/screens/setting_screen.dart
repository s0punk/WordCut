import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/fit_button.dart';
import 'package:flutter_fit_utils_ui/fit_text.dart';
import 'package:flutter_fit_utils_ui/fit_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:word_cut/providers/game_manager.dart';
import 'package:word_cut/providers/word_list.dart';
import 'package:word_cut/utils/l10n/app_localizations.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';
import 'package:word_cut/utils/theme.dart';
import 'package:word_cut/views/screens/welcome_screen.dart';

/// Page des paramètres de l'application.
class SettingScreen extends ConsumerWidget {
  /// Pourcentage de lettres à afficher pour les indices.
  static const double _hintPercentage = 0.5;

  /// Page des paramètres de l'application.
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(l10nProvider);

    // TODO(s0punk): Add option to restart game.

    return SafeArea(
      minimum:
          FitTheme.of(context).pageMargin?.copyWith(top: 24) ?? EdgeInsets.zero,
      child: Column(
        children: [
          FitText.title(strings.settings),
          const SizedBox(height: 12),
          ListTile(
            title: FitText.body(strings.language),
            trailing: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
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
              ),
            ),
          ),
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
              width: MediaQuery.of(context).size.width * 0.3,
              color: ref.watch(colorSchemeProvider).primary,
              child: FitText.button(strings.get),
            ),
          ),
        ],
      ),
    );
  }
}
