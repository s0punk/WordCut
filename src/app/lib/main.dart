import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fit_utils_ui/fit_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_cut/ui/screens/welcome_screen.dart';
import 'package:word_cut/ui/theme.dart';
import 'package:word_cut/utils/l10n/app_localizations.dart';
import 'package:word_cut/utils/l10n/l10n_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  runApp(
    const ProviderScope(
      child: WordCut(),
    ),
  );
}

/// Widget principal de l'application.
class WordCut extends ConsumerWidget {
  /// Widget principal de l'application.
  const WordCut({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FitTheme(
      baseTextStyle: GoogleFonts.workSans(),
      pageMargin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      baseRadius: BorderRadius.all(
        Radius.circular(ref.read(defaultRadiusProvider)),
      ),
      child: MaterialApp(
        restorationScopeId: "word_cut",
        title: "Word Cut",
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: ref.read(l10nProvider.notifier).restoreLocale(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return const WelcomeScreen();
          },
        ),
        theme: ref.watch(themeProvider),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
