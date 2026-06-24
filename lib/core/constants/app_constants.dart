import 'package:flutter/material.dart';

/// App-wide constants for the Masraf Böl application.
abstract final class AppConstants {
  /// Display name of the application.
  static const String appName = 'Masraf Böl';

  /// App package identifier.
  static const String packageName = 'com.masrafbol.app';

  // ──────────────────────────────────────────────
  //  Animation durations
  // ──────────────────────────────────────────────

  /// Fast micro-interactions (ripple, icon change).
  static const Duration animFast = Duration(milliseconds: 150);

  /// Default transitions (page, bottom sheet).
  static const Duration animDefault = Duration(milliseconds: 300);

  /// Slow / spring-like animations (drag settle, modal).
  static const Duration animSlow = Duration(milliseconds: 450);

  /// Snackbar display duration.
  static const Duration snackbarDuration = Duration(seconds: 3);

  // ──────────────────────────────────────────────
  //  Pagination & limits
  // ──────────────────────────────────────────────

  /// Default page size for log / expense lists.
  static const int defaultPageSize = 20;

  /// Maximum group name length.
  static const int maxGroupNameLength = 50;

  /// Maximum expense description length.
  static const int maxExpenseDescriptionLength = 100;

  /// Maximum number of members in a shared group.
  static const int maxGroupMembers = 20;

  // ──────────────────────────────────────────────
  //  Expense defaults
  // ──────────────────────────────────────────────

  /// Default currency for new expenses.
  static const Currency defaultCurrency = Currency.tl;
}

/// Supported currencies in the application.
///
/// Each variant carries its ISO code, display symbol, and a Material icon.
enum Currency {
  /// Turkish Lira
  tl(
    code: 'TRY',
    symbol: '₺',
    displayName: 'Türk Lirası',
    icon: Icons.currency_lira,
  ),

  /// US Dollar
  usd(
    code: 'USD',
    symbol: '\$',
    displayName: 'US Dollar',
    icon: Icons.attach_money,
  ),

  /// Euro
  eur(
    code: 'EUR',
    symbol: '€',
    displayName: 'Euro',
    icon: Icons.euro,
  );

  const Currency({
    required this.code,
    required this.symbol,
    required this.displayName,
    required this.icon,
  });

  /// ISO 4217 currency code (e.g. `TRY`, `USD`, `EUR`).
  final String code;

  /// Display symbol (e.g. `₺`, `$`, `€`).
  final String symbol;

  /// Human-readable name for the UI.
  final String displayName;

  /// Material icon for pickers / chips.
  final IconData icon;

  /// Returns the [Currency] matching [code], or `null` if not found.
  static Currency? fromCode(String code) {
    final upper = code.toUpperCase();
    return Currency.values.cast<Currency?>().firstWhere(
          (c) => c!.code == upper,
          orElse: () => null,
        );
  }
}
