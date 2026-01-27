import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:word_cut/utils/theme.dart';

/// Score animé qui apparait lorsqu'un mot est joué et accepté.
class AnimatedScore extends ConsumerStatefulWidget {
  /// Score a afficher.
  final int score;

  /// Position où le score doit apparaitre.
  final Offset position;

  /// Score animé qui apparait lorsqu'un mot est joué et accepté.
  const AnimatedScore({
    required this.score,
    required this.position,
    super.key,
  });

  @override
  ConsumerState<AnimatedScore> createState() => _AnimatedScoreState();
}

class _AnimatedScoreState extends ConsumerState<AnimatedScore> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    return Positioned(
      left: widget.position.dx,
      top: widget.position.dy,
      child: Text(
        "+${widget.score}",
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
