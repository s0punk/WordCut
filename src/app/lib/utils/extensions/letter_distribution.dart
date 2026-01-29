import 'package:diacritic/diacritic.dart';

/// Extension de la class [String].
/// Rajoute une méthode [getLetterDistribution] qui retourne le nombre de fois
/// que chaque caractère apparait dans le string.
extension LetterExtension on String {
  /// Retourne pour chaque caractère du string le nombre de fois que le
  /// caractère apparait.
  Map<String, int> getLetterDistribution() {
    final distribution = <String, int>{};

    for (final letter in removeDiacritics(this).toLowerCase().split("")) {
      final count = distribution[letter];
      if (count == null) {
        distribution[letter] = 1;
      } else {
        distribution[letter] = count + 1;
      }
    }

    return distribution;
  }
}
