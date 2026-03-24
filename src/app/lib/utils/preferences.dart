import 'package:word_cut/providers/game_mode.dart';

/// Classe qui contient les clés des préférences de l'utilisateur.
abstract class Preferences {
  /// Language sélectionné par l'utilisateur.
  ///
  /// Si null, l'utilisateur utilise la langue de son appareil.
  static const String language = "lang";

  /// Mode de jeux sélectionné par l'utilisateur.
  ///
  /// Si null, le mode est [GameModes.classic].
  static const String gameMode = "game_mode";

  /// Nom du dictionnaire personnalisé de l'utilisateur.
  ///
  /// Si null, aucun dictionnaire personnalisé n'est utilisé.
  static const String customWordList = "custom_word_list";
}
