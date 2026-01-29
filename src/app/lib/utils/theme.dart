import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:word_cut/views/widgets/word_input.dart';

part 'theme.g.dart';

/// Arrondissement par défaut en pixel.
@Riverpod(keepAlive: true)
double defaultRadius(Ref ref) => 22;

/// Provider de la palette de couleur de l'application.
@Riverpod(keepAlive: true)
ColorScheme colorScheme(Ref ref) {
  return ColorScheme.fromSeed(
    seedColor: const Color(0xFF6aaa64),
    primary: const Color(0xFF6aaa64),
  );
}

/// Thème par défaut utilisé par [WordInput].
@Riverpod(keepAlive: true)
PinTheme pinTheme(Ref ref) {
  return const PinTheme(
    width: 56,
    height: 60,
    textStyle: TextStyle(
      fontSize: 16,
    ),
    decoration: BoxDecoration(
      color: Color.fromRGBO(222, 231, 240, .57),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
}

/// Thème d'un [WordInput] pour les mots acceptés.
@Riverpod(keepAlive: true)
PinTheme disabledPinTheme(Ref ref) {
  return PinTheme(
    width: 56,
    height: 60,
    textStyle: TextStyle(
      color: ref.read(colorSchemeProvider).surface,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    decoration: BoxDecoration(
      color: ref.read(colorSchemeProvider).primary,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
  );
}

/// Provider du thème de l'application.
@Riverpod()
ThemeData theme(Ref ref) {
  final colorScheme = ref.watch(colorSchemeProvider);

  return ThemeData(
    colorScheme: colorScheme,
    textTheme: GoogleFonts.workSansTextTheme().copyWith(
      labelLarge: const TextStyle(
        fontSize: 20,
      ),
    ),
    appBarTheme: const AppBarThemeData(
      centerTitle: true,
    ),
    buttonTheme: const ButtonThemeData(
      height: 48,
      minWidth: double.infinity,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(ref.read(defaultRadiusProvider)),
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      elevation: 3,
      behavior: SnackBarBehavior.floating,
      contentTextStyle: GoogleFonts.workSans(
        color: colorScheme.onPrimaryContainer,
        fontSize: 16,
      ),
      backgroundColor: colorScheme.primaryContainer,
    ),
  );
}
