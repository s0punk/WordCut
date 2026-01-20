/// État de la partie.
class GameState {
  /// Score du joueur.
  final int score;

  /// Mots joués par le joueur.
  /// Le premier mot est le mot de départ.
  final List<String> words;

  /// État de la partie.
  GameState({
    required this.words,
    this.score = 0,
  });

  /// Copie l'instance de [GameState] en permettant d'écraser des paramètres.
  GameState copyWith({int? score, List<String>? words}) => GameState(
    words: words ?? this.words,
    score: score ?? this.score,
  );
}
