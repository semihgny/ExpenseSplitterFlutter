import 'package:flutter/material.dart';

/// All color constants for the Masraf Böl design system.
///
/// Colors are organized by semantic role and support both light and dark modes.
/// Follows Material 3 color roles for seamless integration with [ColorScheme].
abstract final class AppColors {
  // ──────────────────────────────────────────────
  //  Primary
  // ──────────────────────────────────────────────

  /// Primary brand color – used for key UI elements.
  static const Color primary = Color(0xFF7C5800);

  /// Primary container – FAB, chips, selected states.
  static const Color primaryContainer = Color(0xFFF0AE03);

  /// Color for content (icons, text) on top of [primary].
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Color for content (icons, text) on top of [primaryContainer].
  static const Color onPrimaryContainer = Color(0xFF624500);

  // ──────────────────────────────────────────────
  //  Secondary
  // ──────────────────────────────────────────────

  /// Secondary color – less prominent components.
  static const Color secondary = Color(0xFF5F5E5E);

  /// Secondary container – secondary chips, toggles.
  static const Color secondaryContainer = Color(0xFFE4E2E1);

  /// Content color on [secondary].
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// Content color on [secondaryContainer].
  static const Color onSecondaryContainer = Color(0xFF1C1B1B);

  // ──────────────────────────────────────────────
  //  Tertiary
  // ──────────────────────────────────────────────

  /// Tertiary accent color – complementary emphasis.
  static const Color tertiary = Color(0xFF006689);

  /// Tertiary container – tertiary chips.
  static const Color tertiaryContainer = Color(0xFF47C6FF);

  /// Content color on [tertiary].
  static const Color onTertiary = Color(0xFFFFFFFF);

  /// Content color on [tertiaryContainer].
  static const Color onTertiaryContainer = Color(0xFF003548);

  // ──────────────────────────────────────────────
  //  Error
  // ──────────────────────────────────────────────

  /// Error color – destructive actions, validation errors.
  static const Color error = Color(0xFFE53935);

  /// Content color on [error].
  static const Color onError = Color(0xFFFFFFFF);

  /// Error container – error banners, backgrounds.
  static const Color errorContainer = Color(0xFFFFDAD6);

  /// Content color on [errorContainer].
  static const Color onErrorContainer = Color(0xFF410002);

  // ──────────────────────────────────────────────
  //  Semantic (non-Material roles)
  // ──────────────────────────────────────────────

  /// Success – positive confirmations.
  static const Color success = Color(0xFF4CAF50);

  /// Warning – caution states.
  static const Color warning = Color(0xFFFFB300);

  /// Secondary text / muted labels.
  static const Color textSecondary = Color(0xFF757575);

  // ──────────────────────────────────────────────
  //  Background & Surface  (Light)
  // ──────────────────────────────────────────────

  /// App background.
  static const Color background = Color(0xFFFAF8F2);

  /// Card / sheet surface.
  static const Color surface = Color(0xFFFFFFFF);

  /// Bright surface variant.
  static const Color surfaceBright = Color(0xFFFFF8F0);

  /// Lowest-emphasis container (e.g. page-level tint).
  static const Color surfaceContainerLow = Color(0xFFFFF2E2);

  /// Default container level.
  static const Color surfaceContainer = Color(0xFFFFF8F0);

  /// Higher-emphasis container.
  static const Color surfaceContainerHigh = Color(0xFFF3E6D6);

  /// Highest-emphasis container.
  static const Color surfaceContainerHighest = Color(0xFFEDE1D1);

  /// Surface variant – chips, filled text fields.
  static const Color surfaceVariant = Color(0xFFEDE1D1);

  /// Surface tint overlay.
  static const Color surfaceTint = Color(0xFF7C5800);

  /// Content color on surfaces.
  static const Color onSurface = Color(0xFF201B11);

  /// Secondary content color on surfaces.
  static const Color onSurfaceVariant = Color(0xFF504533);

  // ──────────────────────────────────────────────
  //  Outline
  // ──────────────────────────────────────────────

  /// High-emphasis outline – text fields, dividers.
  static const Color outline = Color(0xFF837560);

  /// Low-emphasis outline – card borders, separators.
  static const Color outlineVariant = Color(0xFFD5C4AC);

  // ──────────────────────────────────────────────
  //  Inverse
  // ──────────────────────────────────────────────

  /// Inverse surface – snackbars, tooltips.
  static const Color inverseSurface = Color(0xFF362F25);

  /// Content color on [inverseSurface].
  static const Color inverseOnSurface = Color(0xFFFCEFDF);

  /// Primary color on inverse surfaces.
  static const Color inversePrimary = Color(0xFFFFBB1D);

  // ──────────────────────────────────────────────
  //  Scrim & Shadow
  // ──────────────────────────────────────────────

  /// Scrim overlay for modals / bottom sheets.
  static const Color scrim = Color(0xFF000000);

  /// Shadow base color.
  static const Color shadow = Color(0xFF000000);

  // ══════════════════════════════════════════════
  //  DARK THEME COLORS
  // ══════════════════════════════════════════════

  /// Dark theme background.
  static const Color darkBackground = Color(0xFF121212);

  /// Dark theme surface.
  static const Color darkSurface = Color(0xFF1E1E1E);

  /// Dark surface bright variant.
  static const Color darkSurfaceBright = Color(0xFF3D3830);

  /// Dark surface container low.
  static const Color darkSurfaceContainerLow = Color(0xFF1E1A14);

  /// Dark surface container.
  static const Color darkSurfaceContainer = Color(0xFF252118);

  /// Dark surface container high.
  static const Color darkSurfaceContainerHigh = Color(0xFF302B22);

  /// Dark surface container highest.
  static const Color darkSurfaceContainerHighest = Color(0xFF3B362D);

  /// Dark surface variant.
  static const Color darkSurfaceVariant = Color(0xFF504533);

  /// Dark content on surface.
  static const Color darkOnSurface = Color(0xFFEDE1D1);

  /// Dark secondary content on surface.
  static const Color darkOnSurfaceVariant = Color(0xFFD5C4AC);

  /// Dark primary.
  static const Color darkPrimary = Color(0xFFFFBB1D);

  /// Dark primary container.
  static const Color darkPrimaryContainer = Color(0xFFF0AE03);

  /// Dark content on primary.
  static const Color darkOnPrimary = Color(0xFF422D00);

  /// Dark content on primary container.
  static const Color darkOnPrimaryContainer = Color(0xFF201B11);

  /// Dark secondary.
  static const Color darkSecondary = Color(0xFFC8C6C5);

  /// Dark secondary container.
  static const Color darkSecondaryContainer = Color(0xFF474746);

  /// Dark content on secondary.
  static const Color darkOnSecondary = Color(0xFF313030);

  /// Dark content on secondary container.
  static const Color darkOnSecondaryContainer = Color(0xFFE4E2E1);

  /// Dark tertiary.
  static const Color darkTertiary = Color(0xFF47C6FF);

  /// Dark tertiary container.
  static const Color darkTertiaryContainer = Color(0xFF004D68);

  /// Dark content on tertiary.
  static const Color darkOnTertiary = Color(0xFF003548);

  /// Dark content on tertiary container.
  static const Color darkOnTertiaryContainer = Color(0xFFBFE8FF);

  /// Dark error.
  static const Color darkError = Color(0xFFFFB4AB);

  /// Dark content on error.
  static const Color darkOnError = Color(0xFF690005);

  /// Dark error container.
  static const Color darkErrorContainer = Color(0xFF93000A);

  /// Dark content on error container.
  static const Color darkOnErrorContainer = Color(0xFFFFDAD6);

  /// Dark outline.
  static const Color darkOutline = Color(0xFF9D8E78);

  /// Dark outline variant.
  static const Color darkOutlineVariant = Color(0xFF504533);

  /// Dark inverse surface.
  static const Color darkInverseSurface = Color(0xFFEDE1D1);

  /// Dark content on inverse surface.
  static const Color darkInverseOnSurface = Color(0xFF362F25);

  /// Dark inverse primary.
  static const Color darkInversePrimary = Color(0xFF7C5800);

  /// Dark surface tint.
  static const Color darkSurfaceTint = Color(0xFFFFBB1D);

  /// Dark text secondary.
  static const Color darkTextSecondary = Color(0xFF9E9E9E);

  // ──────────────────────────────────────────────
  //  Color Scheme Builders
  // ──────────────────────────────────────────────

  /// Returns the light [ColorScheme] for the app.
  static ColorScheme get lightColorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        surfaceContainerLowest: background,
        surfaceContainerLow: surfaceContainerLow,
        surfaceContainer: surfaceContainer,
        surfaceContainerHigh: surfaceContainerHigh,
        surfaceContainerHighest: surfaceContainerHighest,
        surfaceBright: surfaceBright,
        surfaceTint: surfaceTint,
        outline: outline,
        outlineVariant: outlineVariant,
        inverseSurface: inverseSurface,
        inversePrimary: inversePrimary,
        onInverseSurface: inverseOnSurface,
        scrim: scrim,
        shadow: shadow,
      );

  /// Returns the dark [ColorScheme] for the app.
  static ColorScheme get darkColorScheme => const ColorScheme(
        brightness: Brightness.dark,
        primary: darkPrimary,
        onPrimary: darkOnPrimary,
        primaryContainer: darkPrimaryContainer,
        onPrimaryContainer: darkOnPrimaryContainer,
        secondary: darkSecondary,
        onSecondary: darkOnSecondary,
        secondaryContainer: darkSecondaryContainer,
        onSecondaryContainer: darkOnSecondaryContainer,
        tertiary: darkTertiary,
        onTertiary: darkOnTertiary,
        tertiaryContainer: darkTertiaryContainer,
        onTertiaryContainer: darkOnTertiaryContainer,
        error: darkError,
        onError: darkOnError,
        errorContainer: darkErrorContainer,
        onErrorContainer: darkOnErrorContainer,
        surface: darkSurface,
        onSurface: darkOnSurface,
        onSurfaceVariant: darkOnSurfaceVariant,
        surfaceContainerLowest: darkBackground,
        surfaceContainerLow: darkSurfaceContainerLow,
        surfaceContainer: darkSurfaceContainer,
        surfaceContainerHigh: darkSurfaceContainerHigh,
        surfaceContainerHighest: darkSurfaceContainerHighest,
        surfaceBright: darkSurfaceBright,
        surfaceTint: darkSurfaceTint,
        outline: darkOutline,
        outlineVariant: darkOutlineVariant,
        inverseSurface: darkInverseSurface,
        inversePrimary: darkInversePrimary,
        onInverseSurface: darkInverseOnSurface,
        scrim: scrim,
        shadow: shadow,
      );
}
