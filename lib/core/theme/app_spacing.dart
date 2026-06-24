import 'package:flutter/material.dart';

/// Spacing scale for the Masraf Böl design system.
///
/// All spacing values are in logical pixels and follow a consistent scale.
abstract final class AppSpacing {
  /// 4 lp – extra-small gaps (icon padding, inline spacing).
  static const double xs = 4;

  /// 8 lp – small gaps (list item padding, chip spacing).
  static const double sm = 8;

  /// 16 lp – medium / default gaps (card padding, section spacing).
  static const double md = 16;

  /// 24 lp – large gaps (group spacing, modal padding).
  static const double lg = 24;

  /// 32 lp – extra-large gaps (screen-level padding, header spacing).
  static const double xl = 32;

  // ──────────────────────────────────────────────
  //  Pre-built EdgeInsets (convenience)
  // ──────────────────────────────────────────────

  /// Symmetric horizontal padding – `md` (16).
  static const EdgeInsets paddingHorizontalMd =
      EdgeInsets.symmetric(horizontal: md);

  /// Symmetric vertical padding – `md` (16).
  static const EdgeInsets paddingVerticalMd =
      EdgeInsets.symmetric(vertical: md);

  /// All-side padding – `md` (16).
  static const EdgeInsets paddingAllMd = EdgeInsets.all(md);

  /// All-side padding – `sm` (8).
  static const EdgeInsets paddingAllSm = EdgeInsets.all(sm);

  /// All-side padding – `lg` (24).
  static const EdgeInsets paddingAllLg = EdgeInsets.all(lg);

  /// Symmetric horizontal padding – `lg` (24).
  static const EdgeInsets paddingHorizontalLg =
      EdgeInsets.symmetric(horizontal: lg);

  /// Screen-level padding (horizontal lg, vertical md).
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  // ──────────────────────────────────────────────
  //  SizedBox gaps (for Row / Column spacing)
  // ──────────────────────────────────────────────

  /// Vertical gap – xs (4).
  static const SizedBox verticalXs = SizedBox(height: xs);

  /// Vertical gap – sm (8).
  static const SizedBox verticalSm = SizedBox(height: sm);

  /// Vertical gap – md (16).
  static const SizedBox verticalMd = SizedBox(height: md);

  /// Vertical gap – lg (24).
  static const SizedBox verticalLg = SizedBox(height: lg);

  /// Vertical gap – xl (32).
  static const SizedBox verticalXl = SizedBox(height: xl);

  /// Horizontal gap – xs (4).
  static const SizedBox horizontalXs = SizedBox(width: xs);

  /// Horizontal gap – sm (8).
  static const SizedBox horizontalSm = SizedBox(width: sm);

  /// Horizontal gap – md (16).
  static const SizedBox horizontalMd = SizedBox(width: md);

  /// Horizontal gap – lg (24).
  static const SizedBox horizontalLg = SizedBox(width: lg);

  /// Horizontal gap – xl (32).
  static const SizedBox horizontalXl = SizedBox(width: xl);
}

/// Border radius scale for the Masraf Böl design system.
abstract final class AppRadius {
  /// 8 lp – small radius (chips, small cards).
  static const double sm = 8;

  /// 12 lp – medium radius (cards, dialogs).
  static const double md = 12;

  /// 16 lp – large radius (bottom sheets, image containers).
  static const double lg = 16;

  /// 24 lp – extra-large radius (FAB, modals).
  static const double xl = 24;

  /// 9999 lp – fully rounded (avatar, pill shape).
  static const double full = 9999;

  // ──────────────────────────────────────────────
  //  Pre-built BorderRadius (convenience)
  // ──────────────────────────────────────────────

  /// All corners – sm (8).
  static const BorderRadius borderRadiusSm =
      BorderRadius.all(Radius.circular(sm));

  /// All corners – md (12).
  static const BorderRadius borderRadiusMd =
      BorderRadius.all(Radius.circular(md));

  /// All corners – lg (16).
  static const BorderRadius borderRadiusLg =
      BorderRadius.all(Radius.circular(lg));

  /// All corners – xl (24).
  static const BorderRadius borderRadiusXl =
      BorderRadius.all(Radius.circular(xl));

  /// Fully rounded (pill / circle).
  static const BorderRadius borderRadiusFull =
      BorderRadius.all(Radius.circular(full));

  /// Top corners only – lg (16). Useful for bottom sheets.
  static const BorderRadius borderRadiusTopLg = BorderRadius.only(
    topLeft: Radius.circular(lg),
    topRight: Radius.circular(lg),
  );

  /// Top corners only – xl (24). Useful for modals.
  static const BorderRadius borderRadiusTopXl = BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );
}
