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

class _AnimatedScoreState extends ConsumerState<AnimatedScore>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  );

  late final Animation<double> opacity = Tween<double>(begin: 1, end: 0)
      .animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      );

  late final Animation<Offset> offset =
      Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0, -10),
      ).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      );

  @override
  void initState() {
    super.initState();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    return Positioned(
      left: widget.position.dx,
      top: widget.position.dy,
      child: SlideTransition(
        position: offset,
        child: FadeTransition(
          opacity: opacity,
          child: Text(
            "+${widget.score}",
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
