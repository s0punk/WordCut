import 'package:flutter/material.dart';
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
        state = _getLocale();
      },
    );

    final binding = WidgetsBinding.instance..addObserver(observer);
    ref.onDispose(() => binding.removeObserver(observer));

    return state;
  }

  AppLocalizations _getLocale() => lookupAppLocalizations(
    basicLocaleListResolution(
      [WidgetsBinding.instance.platformDispatcher.locale],
      AppLocalizations.supportedLocales,
    ),
  );
}

/// Observeur qui notifie le provider lorsque la langue change.
class _LocaleObserver extends WidgetsBindingObserver {
  final void Function(List<Locale>? locales) _didChangeLocales;

  _LocaleObserver(this._didChangeLocales);

  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}
