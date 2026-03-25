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
  String get newGame => 'New Game';

  @override
  String get chooseWord => 'Choose a Word';

  @override
  String get seeResults => 'See results';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get getHint => 'Get a hint';

  @override
  String get hardMode => 'Hard mode';

  @override
  String get hardModeDesc => 'Gives a limited time to solve a word.';

  @override
  String get customDictionary => 'Custom dictionary';

  @override
  String get resetTutorials => 'Reset tutorials';

  @override
  String get selectCustomDictionary => 'Select a custom dictionary';

  @override
  String get formatDesc =>
      'The dictionary must be a text file with one word per line. The dictionary must have at least 2 words.';

  @override
  String get useURL => 'From an URL';

  @override
  String get useFile => 'From my device';

  @override
  String get chooseFile => 'Choose file';

  @override
  String get incompatibleFormat => 'Incompatible format';

  @override
  String get availableDictionaries => 'Other available dictionaries';

  @override
  String get score => 'Score';

  @override
  String get gameOver => 'Game Over';

  @override
  String get noMorePossibilities => 'No other words can be played';

  @override
  String get congrats => 'Congratulation!';

  @override
  String get solvedIn => 'Solved in';

  @override
  String get ranOutOfTime => 'Your time is up!';

  @override
  String get get => 'Get';

  @override
  String get showMore => 'Show more';

  @override
  String get ok => 'Ok';

  @override
  String get cancel => 'Cancel';

  @override
  String get select => 'Select';

  @override
  String get remove => 'Remove';

  @override
  String get reset => 'Reset';

  @override
  String get wordNotInList => 'Word not in list';

  @override
  String get wordIncompatible => 'Word not derived from previous one';

  @override
  String get wordNotLongEnough => 'Word not long enough';

  @override
  String get wordRefused => 'Word refused';

  @override
  String get invalidChars => 'Word must contain letters only';

  @override
  String get noOtherPossibleWords => 'No other words can be played';

  @override
  String get endTour => 'End tour';

  @override
  String get done => 'Done';

  @override
  String get next => 'Next';

  @override
  String get settingTutorial =>
      'Tap here to go to settings.\nYou can change game mode, get hints and more.';

  @override
  String get wordInputTutorial =>
      'Create a shorter word by removing 1 to 3 letters. Rearrange the letters to score more points!\n\nDotted slots are optional.';
}
