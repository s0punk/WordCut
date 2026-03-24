import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/flutter_fit_utils_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:word_cut/providers/word_list.dart';
import 'package:word_cut/ui/theme.dart';
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
  bool isLoading = false;

  Future<void> loadURL(String url) async {
    setState(() {
      isLoading = true;
    });

    final navigator = Navigator.of(context);

    try {
      final res = await http.get(Uri.parse(url));

      if (res.statusCode != 200 ||
          !res.headers["content-type"].toString().contains("text/plain")) {
        throw Exception();
      }

      final isValid = await ref
          .read(wordListProvider.notifier)
          .setCustomWordList(url, res.body);

      if (!isValid) {
        throw Exception();
      }

      navigator.pop();
    } on Exception {
      showError();
    }
  }

  Future<void> loadFile() async {
    setState(() {
      isLoading = true;
    });

    final navigator = Navigator.of(context);

    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: ref.read(l10nProvider).selectCustomDictionary,
        type: FileType.custom,
        allowedExtensions: ["txt"],
        withData: true,
      );

      if (result == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final isValid = await ref
          .read(wordListProvider.notifier)
          .setCustomWordList(
            result.files.first.name,
            String.fromCharCodes(result.files.first.bytes ?? []),
          );

      if (!isValid) {
        throw Exception();
      }

      navigator.pop();
    } on Exception {
      showError();
    }
  }

  void showError() {
    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ref.read(colorSchemeProvider).errorContainer,
        content: FitText.body(
          ref.read(l10nProvider).incompatibleFormat,
          style: TextStyle(
            color: ref.read(colorSchemeProvider).onErrorContainer,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(l10nProvider);

    return FitLoadingHandler(
      loading: isLoading,
      child: Scaffold(
        body: SafeArea(
          minimum:
              FitTheme.of(context).pageMargin?.copyWith(top: 24) ??
              EdgeInsets.zero,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  FitText.body(strings.useURL),
                  TextFormField(
                    onFieldSubmitted: loadURL,
                    decoration: const InputDecoration(
                      labelText: "URL",
                      helperText: "https://my-dictionary.txt",
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  FitText.body(strings.useFile),
                  FitButton(
                    onTap: () async {
                      await loadFile();
                    },
                    child: FitText.button(strings.chooseFile),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  FitText.body(strings.availableDictionaries),
                  FitButton(
                    onTap: () async {
                      await loadURL(
                        "https://s0punk.github.io/WordCut/fr-en.txt",
                      );
                    },
                    child: const FitText.button("EN + FR"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
