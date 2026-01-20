/// Extension de la class [String].
/// Rajoute une méthode [getLetterDistribution] qui retourne le nombre de fois
/// que chaque caractère apparait dans le string.
extension LetterExtension on String {
  /// Retourne pour chaque caractère du string le nombre de fois que le
  /// caractère apparait.
  Map<String, int> getLetterDistribution() {
    final distribution = <String, int>{};

    for (final letter in split("")) {
      var count = distribution[letter];
      count = count == null ? 1 : count + 1;
    }

    return distribution;
  }
}
