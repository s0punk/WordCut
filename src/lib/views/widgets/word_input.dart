import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:word_cut/utils/theme.dart';
import 'package:word_cut/utils/uppercase_formatter.dart';

/// Input qui permet d'entrer et d'afficher un mot du jeux.
class WordInput extends ConsumerStatefulWidget {
  /// Mot initial de l'input.
  final String? word;

  /// Longueur maximale de l'input.
  final int? length;

  /// Indique si la valeur de l'input est modifiable par l'utilisateur.
  final bool enabled;

  /// Input qui permet d'entrer et d'afficher un mot du jeux.
  const WordInput({
    this.word,
    this.length,
    this.enabled = false,
    super.key,
  });

  @override
  ConsumerState<WordInput> createState() => _WordInputState();
}

class _WordInputState extends ConsumerState<WordInput> {
  late final TextEditingController controller = TextEditingController(
    text: widget.word,
  );

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: widget.word?.length ?? widget.length ?? 5,
      controller: controller,
      enabled: widget.enabled,
      enableSuggestions: false,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      defaultPinTheme: ref.watch(pinThemeProvider),
      disabledPinTheme: ref.watch(disabledPinThemeProvider),
      inputFormatters: [
        UpperCaseTextFormatter(),
      ],
    );
  }
}
