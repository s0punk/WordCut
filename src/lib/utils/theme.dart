import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme.g.dart';

/// Arrondissement par défaut en pixel.
@Riverpod(keepAlive: true)
double defaultRadius(Ref ref) => 22;

/// Provider de la palette de couleur de l'application.
@Riverpod(keepAlive: true)
ColorScheme colorScheme(Ref ref) {
  return ColorScheme.fromSeed(
    seedColor: const Color(0xFF3AAFB9),
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
