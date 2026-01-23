// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app => 'Word Cut';

  @override
  String get pitch => 'Less letters, more challenge.';

  @override
  String get play => 'Play';

  @override
  String get playAgain => 'Play Again';

  @override
  String get chooseWord => 'Choose a Word';

  @override
  String get settings => 'Settings';

  @override
  String get score => 'Score';

  @override
  String get gameOver => 'Game Over';

  @override
  String get congrats => 'Congratulation!';

  @override
  String get get => 'Get';

  @override
  String get getHint => 'Get a hint';

  @override
  String get wordNotInList => 'Word not in list';

  @override
  String get wordIncompatible => 'Word not derived from previous one';

  @override
  String get wordRefused => 'Word refused';
}
