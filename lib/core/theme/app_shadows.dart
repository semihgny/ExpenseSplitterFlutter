import 'package:flutter/material.dart';

/// Shadow definitions for the Masraf Böl design system.
///
/// Shadows are provided as both individual [BoxShadow] instances and as
/// ready-to-use `List<BoxShadow>` for [BoxDecoration].
abstract final class AppShadows {
  // ──────────────────────────────────────────────
  //  Light shadow – cards, list items
  // ──────────────────────────────────────────────

  /// Light shadow: `0 4px 20px rgba(0,0,0,0.05)`.
  static const BoxShadow light = BoxShadow(
    color: Color(0x0D000000), // 5 % opacity
    offset: Offset(0, 4),
    blurRadius: 20,
  );

  /// Convenience list for [BoxDecoration.boxShadow].
  static const List<BoxShadow> lightShadow = [light];

  // ──────────────────────────────────────────────
  //  Medium shadow – bottom sheets, elevated cards
  // ──────────────────────────────────────────────

  /// Medium shadow: `0 8px 30px rgba(0,0,0,0.12)`.
  static const BoxShadow medium = BoxShadow(
    color: Color(0x1F000000), // 12 % opacity
    offset: Offset(0, 8),
    blurRadius: 30,
  );

  /// Convenience list for [BoxDecoration.boxShadow].
  static const List<BoxShadow> mediumShadow = [medium];

  // ──────────────────────────────────────────────
  //  FAB shadow – floating action button
  // ──────────────────────────────────────────────

  /// FAB shadow: `0 8px 16px rgba(240,174,3,0.3)`.
  ///
  /// Uses the primary-container gold tint for a branded glow effect.
  static const BoxShadow fab = BoxShadow(
    color: Color(0x4DF0AE03), // 30 % opacity of #F0AE03
    offset: Offset(0, 8),
    blurRadius: 16,
  );

  /// Convenience list for [BoxDecoration.boxShadow].
  static const List<BoxShadow> fabShadow = [fab];

  // ──────────────────────────────────────────────
  //  Decoration helpers
  // ──────────────────────────────────────────────

  /// Card decoration with light shadow and rounded corners.
  static BoxDecoration cardDecoration({
    Color color = const Color(0xFFFFFFFF),
    BorderRadius borderRadius =
        const BorderRadius.all(Radius.circular(12)),
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: borderRadius,
      boxShadow: lightShadow,
    );
  }

  /// Elevated card decoration with medium shadow.
  static BoxDecoration elevatedCardDecoration({
    Color color = const Color(0xFFFFFFFF),
    BorderRadius borderRadius =
        const BorderRadius.all(Radius.circular(16)),
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: borderRadius,
      boxShadow: mediumShadow,
    );
  }
}
