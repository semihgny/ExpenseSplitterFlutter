import 'package:intl/intl.dart';

import '../constants/app_constants.dart';

/// Formatting utilities for the Masraf Böl application.
///
/// All formatters are stateless and accessed via static methods.
abstract final class Formatters {
  // ──────────────────────────────────────────────
  //  Currency
  // ──────────────────────────────────────────────

  /// Formats [amount] as a currency string with the appropriate symbol.
  ///
  /// Examples:
  /// ```
  /// Formatters.currency(1234.5)          // ₺1.234,50
  /// Formatters.currency(1234.5, Currency.usd) // $1,234.50
  /// Formatters.currency(1234.5, Currency.eur) // €1.234,50
  /// ```
  static String currency(
    double amount, [
    Currency currency = Currency.tl,
  ]) {
    final String locale;
    switch (currency) {
      case Currency.tl:
        locale = 'tr_TR';
      case Currency.usd:
        locale = 'en_US';
      case Currency.eur:
        locale = 'de_DE'; // euro convention: dot for thousands, comma for decimal
    }

    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: currency.symbol,
      decimalDigits: 2,
    );

    return formatter.format(amount);
  }

  /// Formats [amount] as a compact currency (e.g. ₺1,2B for 1200).
  static String currencyCompact(
    double amount, [
    Currency currency = Currency.tl,
  ]) {
    final String locale;
    switch (currency) {
      case Currency.tl:
        locale = 'tr_TR';
      case Currency.usd:
        locale = 'en_US';
      case Currency.eur:
        locale = 'de_DE';
    }

    final formatter = NumberFormat.compactCurrency(
      locale: locale,
      symbol: currency.symbol,
      decimalDigits: 1,
    );

    return formatter.format(amount);
  }

  /// Formats [amount] as a plain number without currency symbol.
  ///
  /// Example: `1234.5` → `1.234,50` (Turkish locale).
  static String number(
    double amount, {
    int decimalDigits = 2,
    String locale = 'tr_TR',
  }) {
    final formatter = NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  // ──────────────────────────────────────────────
  //  Date & Time
  // ──────────────────────────────────────────────

  /// Full date with day name: `10 Haziran 2026, Çarşamba`.
  static String dateFull(DateTime date, {String locale = 'tr_TR'}) {
    return DateFormat('d MMMM y, EEEE', locale).format(date);
  }

  /// Medium date: `10 Haz 2026`.
  static String dateMedium(DateTime date, {String locale = 'tr_TR'}) {
    return DateFormat('d MMM y', locale).format(date);
  }

  /// Short date: `10.06.2026`.
  static String dateShort(DateTime date, {String locale = 'tr_TR'}) {
    return DateFormat('dd.MM.y', locale).format(date);
  }

  /// Time only: `14:30`.
  static String time(DateTime date, {String locale = 'tr_TR'}) {
    return DateFormat('HH:mm', locale).format(date);
  }

  /// Date with time: `10 Haz 2026, 14:30`.
  static String dateTime(DateTime date, {String locale = 'tr_TR'}) {
    return DateFormat('d MMM y, HH:mm', locale).format(date);
  }

  /// Relative date label.
  ///
  /// Returns `Bugün`, `Dün`, or falls back to [dateMedium].
  static String dateRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    final diff = today.difference(target).inDays;

    if (diff == 0) return 'Bugün';
    if (diff == 1) return 'Dün';
    if (diff == -1) return 'Yarın';
    return dateMedium(date);
  }

  /// Month-year label: `Haziran 2026`.
  static String monthYear(DateTime date, {String locale = 'tr_TR'}) {
    return DateFormat('MMMM y', locale).format(date);
  }

  // ──────────────────────────────────────────────
  //  Number
  // ──────────────────────────────────────────────

  /// Formats a percentage: `75,5%`.
  static String percentage(
    double value, {
    int decimalDigits = 1,
    String locale = 'tr_TR',
  }) {
    final formatter = NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: decimalDigits,
    );
    return '${formatter.format(value)}%';
  }

  /// Compact number: `1,2B` for 1200 in Turkish.
  static String numberCompact(
    double value, {
    String locale = 'tr_TR',
  }) {
    return NumberFormat.compact(locale: locale).format(value);
  }

  /// Integer formatter (no decimals): `1.234`.
  static String integer(
    int value, {
    String locale = 'tr_TR',
  }) {
    return NumberFormat.decimalPattern(locale).format(value);
  }
}
