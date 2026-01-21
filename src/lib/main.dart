import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/fit_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_cut/utils/l10n/app_localizations.dart';
import 'package:word_cut/utils/theme.dart';
import 'package:word_cut/views/screens/welcome_screen.dart';

void main() {
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
        title: "WordCut",
        debugShowCheckedModeBanner: false,
        home: const WelcomeScreen(),
        theme: ref.watch(themeProvider),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
