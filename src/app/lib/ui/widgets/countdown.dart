import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fit_utils_ui/fit_text.dart';
import 'package:word_cut/utils/extensions/duration.dart';

/// Widget qui affiche un countdown timer.
class Countdown extends StatefulWidget {
  /// Date à laquelle le timer à commencé.
  final DateTime start;

  /// Durée du timer.
  final Duration duration;

  /// Indique si le timer doit avancer.
  final bool running;

  /// Appelé lorsque le timer est terminé.
  final VoidCallback? onDone;

  /// Widget qui affiche un countdown timer.
  const Countdown({
    required this.start,
    required this.duration,
    this.running = true,
    this.onDone,
    super.key,
  });

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  static const Duration tickDuration = Duration(seconds: 1);

  late Duration remaining = getRemainingTime();
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(tickDuration, (_) {
      setState(() {
        remaining = remaining - tickDuration;

        if (remaining.inSeconds <= 0 || !widget.running) {
          timer.cancel();

          if (widget.running) {
            widget.onDone?.call();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Duration getRemainingTime() {
    final ellapsed = DateTime.now().difference(widget.start);
    return widget.duration - ellapsed;
  }

  @override
  Widget build(BuildContext context) {
    // On ne veut afficher une valeur plus petite que 0.
    return FitText.body(
      (remaining.inSeconds <= 0 ? Duration.zero : remaining).toTimerString(),
      style: TextStyle(
        color: remaining.inSeconds <= 10 ? Colors.red : null,
      ),
    );
  }
}
