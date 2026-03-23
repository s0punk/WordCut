/// Extension de la classe [Duration].
extension DurationExtension on Duration {
  /// Retourne la [Duration] en [String] sous la forme {hh:mm:ss}.
  String toPrettyString() {
    final val = toString();
    return val.substring(0, val.indexOf("."));
  }

  /// Retourne un [String] pour représenter un timer.
  ///
  /// Affiche seulement les minutes et les secondes.
  String toTimerString() {
    final minutes = inMinutes % 60;
    final seconds = inSeconds - inMinutes * 60;

    return "$minutes:${seconds.toString().padLeft(2, "0")}";
  }
}
