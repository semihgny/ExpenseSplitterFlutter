import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography definitions for the Masraf Böl design system.
///
/// All styles use the *Inter* typeface via Google Fonts.
/// Sizes, line-heights and weights are taken directly from the design tokens.
abstract final class AppTypography {
  // ──────────────────────────────────────────────
  //  Individual text styles
  // ──────────────────────────────────────────────

  /// Headline Large – 28/34 Bold
  /// Use for: screen titles, hero text.
  static TextStyle get headlineLg => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 34 / 28, // line-height 34
        letterSpacing: 0,
      );

  /// Headline Medium – 24/30 Bold
  /// Use for: section headers, dialogs.
  static TextStyle get headlineMd => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 30 / 24, // line-height 30
        letterSpacing: 0,
      );

  /// Title Medium – 20/26 Bold
  /// Use for: card titles, toolbar titles.
  static TextStyle get titleMd => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 26 / 20, // line-height 26
        letterSpacing: 0,
      );

  /// Body Large – 16/24 Medium
  /// Use for: primary body text, descriptions.
  static TextStyle get bodyLg => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 24 / 16, // line-height 24
        letterSpacing: 0,
      );

  /// Body Small – 14/20 Regular
  /// Use for: secondary body text, captions.
  static TextStyle get bodySm => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14, // line-height 20
        letterSpacing: 0,
      );

  /// Label Small – 12/16 Regular
  /// Use for: chip labels, helper text, timestamps.
  static TextStyle get labelSm => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12, // line-height 16
        letterSpacing: 0,
      );

  // ──────────────────────────────────────────────
  //  TextTheme factory
  // ──────────────────────────────────────────────

  /// Builds a complete [TextTheme] mapped to Material 3 roles.
  ///
  /// The mapping is intentional – our 6 design-token styles are placed
  /// at the Material roles where they'll be picked up by default widgets:
  ///
  /// | Design token  | Material role        |
  /// |---------------|----------------------|
  /// | headlineLg    | headlineLarge        |
  /// | headlineMd    | headlineMedium       |
  /// | titleMd       | titleMedium / Large  |
  /// | bodyLg        | bodyLarge            |
  /// | bodySm        | bodyMedium / Small   |
  /// | labelSm       | labelSmall           |
  static TextTheme textTheme({Color? color}) {
    final baseColor = color ?? const Color(0xFF201B11);

    return TextTheme(
      headlineLarge: headlineLg.copyWith(color: baseColor),
      headlineMedium: headlineMd.copyWith(color: baseColor),
      headlineSmall: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 28 / 22,
        letterSpacing: 0,
        color: baseColor,
      ),
      titleLarge: titleMd.copyWith(color: baseColor),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 24 / 16,
        letterSpacing: 0.15,
        color: baseColor,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 20 / 14,
        letterSpacing: 0.1,
        color: baseColor,
      ),
      bodyLarge: bodyLg.copyWith(color: baseColor),
      bodyMedium: bodySm.copyWith(color: baseColor),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
        letterSpacing: 0.4,
        color: baseColor,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 20 / 14,
        letterSpacing: 0.1,
        color: baseColor,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 16 / 12,
        letterSpacing: 0.5,
        color: baseColor,
      ),
      labelSmall: labelSm.copyWith(color: baseColor),
    );
  }
}
