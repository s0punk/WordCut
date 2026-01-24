import 'package:flutter/material.dart';

/// Score animé qui apparait lorsqu'un mot est joué et accepté.
class AnimatedScore extends StatefulWidget {
  /// Score a afficher.
  final int score;

  /// Score animé qui apparait lorsqu'un mot est joué et accepté.
  const AnimatedScore({
    required this.score,
    super.key,
  });

  @override
  State<AnimatedScore> createState() => _AnimatedScoreState();
}

class _AnimatedScoreState extends State<AnimatedScore> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.score.toString());
  }
}
