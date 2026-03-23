// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_play_result.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wordPlayResultHash() => r'92a0923e9605e71937b8de54c82c76f4ee884c53';

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

/// Provider des labels des [WordPlayResult].
///
/// Copied from [wordPlayResult].
@ProviderFor(wordPlayResult)
const wordPlayResultProvider = WordPlayResultFamily();

/// Provider des labels des [WordPlayResult].
///
/// Copied from [wordPlayResult].
class WordPlayResultFamily extends Family<String> {
  /// Provider des labels des [WordPlayResult].
  ///
  /// Copied from [wordPlayResult].
  const WordPlayResultFamily();

  /// Provider des labels des [WordPlayResult].
  ///
  /// Copied from [wordPlayResult].
  WordPlayResultProvider call(WordPlayResult result) {
    return WordPlayResultProvider(result);
  }

  @override
  WordPlayResultProvider getProviderOverride(
    covariant WordPlayResultProvider provider,
  ) {
    return call(provider.result);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'wordPlayResultProvider';
}

/// Provider des labels des [WordPlayResult].
///
/// Copied from [wordPlayResult].
class WordPlayResultProvider extends AutoDisposeProvider<String> {
  /// Provider des labels des [WordPlayResult].
  ///
  /// Copied from [wordPlayResult].
  WordPlayResultProvider(WordPlayResult result)
    : this._internal(
        (ref) => wordPlayResult(ref as WordPlayResultRef, result),
        from: wordPlayResultProvider,
        name: r'wordPlayResultProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$wordPlayResultHash,
        dependencies: WordPlayResultFamily._dependencies,
        allTransitiveDependencies:
            WordPlayResultFamily._allTransitiveDependencies,
        result: result,
      );

  WordPlayResultProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.result,
  }) : super.internal();

  final WordPlayResult result;

  @override
  Override overrideWith(String Function(WordPlayResultRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: WordPlayResultProvider._internal(
        (ref) => create(ref as WordPlayResultRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        result: result,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _WordPlayResultProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WordPlayResultProvider && other.result == result;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, result.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WordPlayResultRef on AutoDisposeProviderRef<String> {
  /// The parameter `result` of this provider.
  WordPlayResult get result;
}

class _WordPlayResultProviderElement extends AutoDisposeProviderElement<String>
    with WordPlayResultRef {
  _WordPlayResultProviderElement(super.provider);

  @override
  WordPlayResult get result => (origin as WordPlayResultProvider).result;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
