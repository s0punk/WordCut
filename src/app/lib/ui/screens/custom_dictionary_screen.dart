import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/fit_button.dart';
import 'package:flutter_fit_utils_ui/fit_text.dart';
import 'package:flutter_fit_utils_ui/fit_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';

/// Page qui permet d'utiliser un dictionnaire personnalisé lors des parties.
///
/// Permet de sélectionner un dictionnaire via un liens web ou un fichier sur
/// l'appareil de l'utilisateur.
class CustomWordListScreen extends ConsumerStatefulWidget {
  /// Page qui permet d'utiliser un dictionnaire personnalisé lors des parties.
  const CustomWordListScreen({super.key});

  @override
  ConsumerState<CustomWordListScreen> createState() =>
      _CustomDictionaryScreenState();
}

class _CustomDictionaryScreenState extends ConsumerState<CustomWordListScreen> {
  Future<void> loadURL(String url) async {}

  Future<void> loadFile() async {}

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(l10nProvider);

    final trailingWidth = clampDouble(
      MediaQuery.of(context).size.width * 0.35,
      0,
      150,
    );

    return SafeArea(
      minimum:
          FitTheme.of(context).pageMargin?.copyWith(top: 24) ?? EdgeInsets.zero,
      child: Column(
        spacing: 24,
        children: [
          FitText.title(strings.selectCustomDictionary),
          Card(
            child: FitText.body(
              strings.formatDesc,
              margin: const EdgeInsets.all(8),
            ),
          ),
          ListTile(
            title: FitText.body(strings.useURL),
            trailing: SizedBox(
              width: trailingWidth,
              child: TextFormField(
                onFieldSubmitted: loadURL,
                decoration: const InputDecoration(
                  labelText: "URL",
                  helperText: "https://my-dictionary.txt",
                ),
              ),
            ),
          ),
          ListTile(
            title: FitText.body(strings.useFile),
            trailing: FitButton(
              onTap: () async {
                showModalBottomSheet<void>(
                  context: context,
                  showDragHandle: true,
                  useSafeArea: true,
                  builder: (context) => const SizedBox(
                    width: double.infinity,
                    child: CustomWordListScreen(),
                  ),
                );
              },
              width: trailingWidth,
              child: FitText.button(strings.chooseFile),
            ),
          ),
        ],
      ),
    );
  }
}
