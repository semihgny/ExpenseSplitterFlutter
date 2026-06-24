import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Rounded text input field following the Masraf Böl design system.
///
/// Shows [outlineVariant] border when unfocused and [primaryContainer] when focused.
/// Supports label, hint, prefix/suffix widgets, and validation.
class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.errorText,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.borderRadius = 14,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? suffix;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final primaryContainer = Theme.of(context).colorScheme.primary;
    final outlineVariant = Theme.of(context).colorScheme.outlineVariant;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final onSurfaceVariant = Theme.of(context).textTheme.bodySmall?.color ?? Theme.of(context).colorScheme.onSurfaceVariant;
    final errorColor = Theme.of(context).colorScheme.error;
    final background = Theme.of(context).colorScheme.surfaceContainerLowest;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: outlineVariant, width: 1),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: primaryContainer, width: 1.5),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: errorColor, width: 1),
    );

    final focusedErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: errorColor, width: 1.5),
    );

    final disabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: outlineVariant.withValues(alpha: 0.5), width: 1),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: onSurface,
              height: 20 / 14,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          maxLines: maxLines,
          minLines: minLines,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          onTap: onTap,
          validator: validator,
          autofocus: autofocus,
          textCapitalization: textCapitalization,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: onSurface,
            height: 24 / 16,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: onSurfaceVariant.withValues(alpha: 0.6),
              height: 24 / 16,
            ),
            errorText: errorText,
            errorStyle: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: errorColor,
            ),
            filled: true,
            fillColor: background,
            prefixIcon: prefixIcon,
            prefix: prefix,
            suffixIcon: suffixIcon,
            suffix: suffix,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: border,
            enabledBorder: border,
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedErrorBorder,
            disabledBorder: disabledBorder,
          ),
        ),
      ],
    );
  }
}

/// Underline-style amount input, used for entering monetary values.
///
/// Features a large centered text style with a currency prefix and
/// underline decoration that changes color on focus.
class AppAmountInput extends StatelessWidget {
  const AppAmountInput({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = '0.00',
    this.currencySymbol = '₺',
    this.onChanged,
    this.autofocus = false,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final String currencySymbol;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final primaryContainer = Theme.of(context).colorScheme.primary;
    final outlineVariant = Theme.of(context).colorScheme.outlineVariant;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final onSurfaceVariant = Theme.of(context).textTheme.bodySmall?.color ?? Theme.of(context).colorScheme.onSurfaceVariant;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      enabled: enabled,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*[.,]?\d{0,2}')),
      ],
      onChanged: onChanged,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: onSurface,
        height: 34 / 28,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: onSurfaceVariant.withValues(alpha: 0.3),
          height: 34 / 28,
        ),
        prefixText: '$currencySymbol ',
        prefixStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: onSurface,
          height: 34 / 28,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: outlineVariant, width: 1),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: outlineVariant, width: 1),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryContainer, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}
