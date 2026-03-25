// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wordListHash() => r'38b245dd9b776e32e778180b93f1fb32f7478f7a';

/// Provider de la liste de mot selon la langue utilisé.
///
/// Copied from [WordList].
@ProviderFor(WordList)
final wordListProvider = AsyncNotifierProvider<WordList, Set<String>>.internal(
  WordList.new,
  name: r'wordListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wordListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WordList = AsyncNotifier<Set<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
