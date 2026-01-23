import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
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

  /// Indique si l'input doit être focused par défaut.
  final bool autoFocus;

  /// Callback a exécuter lorsque l'utilisateur soumet son input.
  final void Function(String value)? onCompleted;

  /// Input qui permet d'entrer et d'afficher un mot du jeux.
  const WordInput({
    this.word,
    this.length,
    this.enabled = false,
    this.autoFocus = false,
    this.onCompleted,
    super.key,
  });

  @override
  ConsumerState<WordInput> createState() => _WordInputState();
}

class _WordInputState extends ConsumerState<WordInput> {
  late final TextEditingController controller = TextEditingController(
    text: widget.word?.toUpperCase(),
  );

  @override
  Widget build(BuildContext context) {
    final pinTheme = ref.watch(pinThemeProvider);
    final disabledPinTheme = ref.watch(disabledPinThemeProvider);

    return Align(
      child: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 8.0;
          final length = widget.word?.length ?? widget.length ?? 5;

          return Pinput.builder(
            separatorBuilder: (_) => const SizedBox(width: spacing),
            builder: (context, state) {
              final theme = widget.enabled ? pinTheme : disabledPinTheme;

              final pinSize = clampDouble(
                (constraints.maxWidth - (spacing * (length - 1))) / length,
                0,
                theme.width ?? 56,
              );

              return DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  padding: EdgeInsets.zero,
                  radius: const Radius.circular(8),
                  dashPattern: [10, 4],
                  color: state.index >= length - 3 && widget.enabled
                      ? Colors.black
                      : Colors.transparent,
                ),
                child: Container(
                  width: pinSize,
                  height: theme.height,
                  margin: theme.margin,
                  padding: theme.padding,
                  decoration: theme.decoration,
                  constraints: theme.constraints,
                  alignment: Alignment.center,
                  child: Text(
                    state.value,
                    style: theme.textStyle,
                  ),
                ),
              );
            },
            length: length,
            controller: controller,
            onSubmitted: (value) =>
                widget.onCompleted?.call(value.toLowerCase()),
            autofocus: widget.autoFocus,
            enabled: widget.enabled,
            enableSuggestions: false,
            keyboardType: TextInputType.text,
            closeKeyboardWhenCompleted: false,
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
          );
        },
      ),
    );
  }
}
