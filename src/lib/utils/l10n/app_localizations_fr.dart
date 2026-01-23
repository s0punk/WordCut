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
  String get chooseWord => 'Choisir un mot';

  @override
  String get settings => 'Paramètres';

  @override
  String get score => 'Score';

  @override
  String get gameOver => 'Partie terminée';

  @override
  String get congrats => 'Félicitation!';

  @override
  String get get => 'Obtenir';

  @override
  String get getHint => 'Obtenir un indice';
}
