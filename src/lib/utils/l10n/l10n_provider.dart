import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:word_cut/utils/l10n/app_localizations.dart';

part 'l10n_provider.g.dart';

/// Provider des strings localisés de l'application.
@Riverpod(keepAlive: true)
class L10n extends _$L10n {
  @override
  AppLocalizations build() {
    state = _getLocale();

    final observer = _LocaleObserver(
      (_) {
        final old = state.localeName;
        state = _getLocale();
        debugPrint("INF: Changed locale from $old to ${state.localeName}");
      },
    );

    final binding = WidgetsBinding.instance..addObserver(observer);
    ref.onDispose(() => binding.removeObserver(observer));

    return state;
  }

  /// Change le [Locale] utilisé par l'application.
  void setLocale(Locale locale) {
    state = _getLocale(locale: locale);
    // TODO(s0punk): save preferred locale localy.
  }

  AppLocalizations _getLocale({Locale? locale}) => lookupAppLocalizations(
    basicLocaleListResolution(
      [locale ?? WidgetsBinding.instance.platformDispatcher.locale],
      AppLocalizations.supportedLocales,
    ),
  );
}

/// Provider des labels des [Locale] supportés par l'application.
@riverpod
String localeLabel(Ref ref, String code) => switch (code) {
  "en" => "English",
  "fr" => "Français",
  _ => code,
};

/// Observeur qui notifie le provider lorsque la langue change.
class _LocaleObserver extends WidgetsBindingObserver {
  final void Function(List<Locale>? locales) _didChangeLocales;

  _LocaleObserver(this._didChangeLocales);

  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}
