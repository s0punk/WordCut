/// Extension de la classe [Duration].
extension DurationExtension on Duration {
  /// Retourne la [Duration] en [String] sous la forme {hh:mm:ss}.
  String toPrettyString() {
    final val = toString();
    return val.substring(0, val.indexOf("."));
  }
}
