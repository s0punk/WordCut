// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get app => 'Word Cut';

  @override
  String get pitch => 'Moins de lettres, plus de défis.';

  @override
  String get play => 'Jouer';

  @override
  String get playAgain => 'Rejouer';

  @override
  String get newGame => 'Nouvelle partie';

  @override
  String get chooseWord => 'Choisir un mot';

  @override
  String get seeResults => 'Voir les résultats';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get getHint => 'Obtenir un indice';

  @override
  String get score => 'Score';

  @override
  String get gameOver => 'Partie terminée';

  @override
  String get noMorePossibilities => 'Aucun autre mot ne peut être joué';

  @override
  String get congrats => 'Félicitation!';

  @override
  String get solvedIn => 'Résolue en';

  @override
  String get get => 'Obtenir';

  @override
  String get showMore => 'Voir plus';

  @override
  String get wordNotInList => 'Le mot ne fait pas partie de la liste';

  @override
  String get wordIncompatible => 'Le mot ne découle pas du précédent';

  @override
  String get wordNotLongEnough => 'Le mot n\'est pas assez long';

  @override
  String get wordRefused => 'Mot refusé';

  @override
  String get invalidChars => 'Le mot doit contenir des lettres seulement';

  @override
  String get noOtherPossibleWords => 'Aucun mot possible';
}
