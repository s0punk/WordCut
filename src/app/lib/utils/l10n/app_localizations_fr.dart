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
  String get hardMode => 'Mode difficile';

  @override
  String get hardModeDesc => 'Donne un temps limité pour résoudre un mot.';

  @override
  String get customDictionary => 'Dictionnaire personnalisé';

  @override
  String get selectCustomDictionary =>
      'Sélectionner un dictionnaire personnalisé';

  @override
  String get formatDesc =>
      'Le dictionnaire personnalisé doit être sous la forme d\'un fichier texte avec 1 mot par ligne.';

  @override
  String get useURL => 'Via un URL';

  @override
  String get useFile => 'Via mon appareil';

  @override
  String get chooseFile => 'Choisir un fichier';

  @override
  String get incompatibleFormat => 'Format incompatible';

  @override
  String detectedWordsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mots détectés',
      one: '1 mot détecté',
    );
    return '$_temp0';
  }

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
  String get ranOutOfTime => 'Votre temps est écoulé!';

  @override
  String get get => 'Obtenir';

  @override
  String get showMore => 'Voir plus';

  @override
  String get ok => 'Ok';

  @override
  String get cancel => 'Annuler';

  @override
  String get select => 'Sélectionner';

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
