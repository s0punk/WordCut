// coverage:ignore-file
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @app.
  ///
  /// In en, this message translates to:
  /// **'Word Cut'**
  String get app;

  /// No description provided for @pitch.
  ///
  /// In en, this message translates to:
  /// **'Less letters, more challenge.'**
  String get pitch;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @newGame.
  ///
  /// In en, this message translates to:
  /// **'New Game'**
  String get newGame;

  /// No description provided for @chooseWord.
  ///
  /// In en, this message translates to:
  /// **'Choose a Word'**
  String get chooseWord;

  /// No description provided for @seeResults.
  ///
  /// In en, this message translates to:
  /// **'See results'**
  String get seeResults;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @getHint.
  ///
  /// In en, this message translates to:
  /// **'Get a hint'**
  String get getHint;

  /// No description provided for @hardMode.
  ///
  /// In en, this message translates to:
  /// **'Hard mode'**
  String get hardMode;

  /// No description provided for @hardModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Gives a limited time to solve a word.'**
  String get hardModeDesc;

  /// No description provided for @customDictionary.
  ///
  /// In en, this message translates to:
  /// **'Custom dictionary'**
  String get customDictionary;

  /// No description provided for @selectCustomDictionary.
  ///
  /// In en, this message translates to:
  /// **'Select a custom dictionary'**
  String get selectCustomDictionary;

  /// No description provided for @formatDesc.
  ///
  /// In en, this message translates to:
  /// **'The dictionary must be a text file with one word per line.'**
  String get formatDesc;

  /// No description provided for @useURL.
  ///
  /// In en, this message translates to:
  /// **'From an URL'**
  String get useURL;

  /// No description provided for @useFile.
  ///
  /// In en, this message translates to:
  /// **'From my device'**
  String get useFile;

  /// No description provided for @chooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get chooseFile;

  /// No description provided for @incompatibleFormat.
  ///
  /// In en, this message translates to:
  /// **'Incompatible format'**
  String get incompatibleFormat;

  /// No description provided for @detectedWordsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 word} other{{count} words}} detected'**
  String detectedWordsCount(num count);

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @gameOver.
  ///
  /// In en, this message translates to:
  /// **'Game Over'**
  String get gameOver;

  /// No description provided for @noMorePossibilities.
  ///
  /// In en, this message translates to:
  /// **'No other words can be played'**
  String get noMorePossibilities;

  /// No description provided for @congrats.
  ///
  /// In en, this message translates to:
  /// **'Congratulation!'**
  String get congrats;

  /// No description provided for @solvedIn.
  ///
  /// In en, this message translates to:
  /// **'Solved in'**
  String get solvedIn;

  /// No description provided for @ranOutOfTime.
  ///
  /// In en, this message translates to:
  /// **'Your time is up!'**
  String get ranOutOfTime;

  /// No description provided for @get.
  ///
  /// In en, this message translates to:
  /// **'Get'**
  String get get;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get showMore;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @wordNotInList.
  ///
  /// In en, this message translates to:
  /// **'Word not in list'**
  String get wordNotInList;

  /// No description provided for @wordIncompatible.
  ///
  /// In en, this message translates to:
  /// **'Word not derived from previous one'**
  String get wordIncompatible;

  /// No description provided for @wordNotLongEnough.
  ///
  /// In en, this message translates to:
  /// **'Word not long enough'**
  String get wordNotLongEnough;

  /// No description provided for @wordRefused.
  ///
  /// In en, this message translates to:
  /// **'Word refused'**
  String get wordRefused;

  /// No description provided for @invalidChars.
  ///
  /// In en, this message translates to:
  /// **'Word must contain letters only'**
  String get invalidChars;

  /// No description provided for @noOtherPossibleWords.
  ///
  /// In en, this message translates to:
  /// **'No other words can be played'**
  String get noOtherPossibleWords;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
