import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

/// Provide une instance de [SharedPreferencesAsync].
@riverpod
SharedPreferencesAsync preferences(Ref ref) => SharedPreferencesAsync();
