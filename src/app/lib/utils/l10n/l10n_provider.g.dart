// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'l10n_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$localeLabelHash() => r'77b2d215a3525394fe4740618f77538421f960cc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider des labels des [Locale] supportés par l'application.
///
/// Copied from [localeLabel].
@ProviderFor(localeLabel)
const localeLabelProvider = LocaleLabelFamily();

/// Provider des labels des [Locale] supportés par l'application.
///
/// Copied from [localeLabel].
class LocaleLabelFamily extends Family<String> {
  /// Provider des labels des [Locale] supportés par l'application.
  ///
  /// Copied from [localeLabel].
  const LocaleLabelFamily();

  /// Provider des labels des [Locale] supportés par l'application.
  ///
  /// Copied from [localeLabel].
  LocaleLabelProvider call(String code) {
    return LocaleLabelProvider(code);
  }

  @override
  LocaleLabelProvider getProviderOverride(
    covariant LocaleLabelProvider provider,
  ) {
    return call(provider.code);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'localeLabelProvider';
}

/// Provider des labels des [Locale] supportés par l'application.
///
/// Copied from [localeLabel].
class LocaleLabelProvider extends AutoDisposeProvider<String> {
  /// Provider des labels des [Locale] supportés par l'application.
  ///
  /// Copied from [localeLabel].
  LocaleLabelProvider(String code)
    : this._internal(
        (ref) => localeLabel(ref as LocaleLabelRef, code),
        from: localeLabelProvider,
        name: r'localeLabelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$localeLabelHash,
        dependencies: LocaleLabelFamily._dependencies,
        allTransitiveDependencies: LocaleLabelFamily._allTransitiveDependencies,
        code: code,
      );

  LocaleLabelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.code,
  }) : super.internal();

  final String code;

  @override
  Override overrideWith(String Function(LocaleLabelRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: LocaleLabelProvider._internal(
        (ref) => create(ref as LocaleLabelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        code: code,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _LocaleLabelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LocaleLabelProvider && other.code == code;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, code.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LocaleLabelRef on AutoDisposeProviderRef<String> {
  /// The parameter `code` of this provider.
  String get code;
}

class _LocaleLabelProviderElement extends AutoDisposeProviderElement<String>
    with LocaleLabelRef {
  _LocaleLabelProviderElement(super.provider);

  @override
  String get code => (origin as LocaleLabelProvider).code;
}

String _$l10nHash() => r'992b95deb8ce7c670da35eec2dcb4c2a81c001a3';

/// Provider des strings localisés de l'application.
///
/// Copied from [L10n].
@ProviderFor(L10n)
final l10nProvider = NotifierProvider<L10n, AppLocalizations>.internal(
  L10n.new,
  name: r'l10nProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$l10nHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$L10n = Notifier<AppLocalizations>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
