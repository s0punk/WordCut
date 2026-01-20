import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

/// Input qui permet d'entrer et d'afficher un mot du jeux.
class WordInput extends StatefulWidget {
  /// Contrôlleur de l'input.
  final TextEditingController? controller;

  /// Indique si la valeur de l'input est modifiable par l'utilisateur.
  final bool enabled;

  /// Input qui permet d'entrer et d'afficher un mot du jeux.
  const WordInput({
    this.controller,
    this.enabled = false,
    super.key,
  });

  @override
  State<WordInput> createState() => _WordInputState();
}

class _WordInputState extends State<WordInput> {
  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: widget.controller?.text.length ?? 5,
      controller: widget.controller,
      enabled: widget.enabled,
    );
  }
}
