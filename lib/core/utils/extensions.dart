import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import 'formatters.dart';

// ══════════════════════════════════════════════
//  BuildContext Extensions
// ══════════════════════════════════════════════

/// Quick access to theme properties from any widget.
extension BuildContextExtensions on BuildContext {
  // ── Theme ──
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  // ── Color shortcuts ──
  Color get primaryColor => colorScheme.primary;
  Color get onPrimaryColor => colorScheme.onPrimary;
  Color get primaryContainerColor => colorScheme.primaryContainer;
  Color get surfaceColor => colorScheme.surface;
  Color get onSurfaceColor => colorScheme.onSurface;
  Color get errorColor => colorScheme.error;
  Color get outlineColor => colorScheme.outline;
  Color get outlineVariantColor => colorScheme.outlineVariant;

  // ── Text style shortcuts ──
  TextStyle? get headlineLg => textTheme.headlineLarge;
  TextStyle? get headlineMd => textTheme.headlineMedium;
  TextStyle? get titleMd => textTheme.titleMedium;
  TextStyle? get bodyLg => textTheme.bodyLarge;
  TextStyle? get bodySm => textTheme.bodyMedium;
  TextStyle? get labelSm => textTheme.labelSmall;

  // ── Media query ──
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  double get bottomInset => viewInsets.bottom;
  bool get isKeyboardOpen => viewInsets.bottom > 0;

  // ── Brightness ──
  Brightness get brightness => theme.brightness;
  bool get isDarkMode => brightness == Brightness.dark;

  // ── Navigation ──
  NavigatorState get navigator => Navigator.of(this);

  /// Pops the current route and returns [result] to the caller.
  void pop<T>([T? result]) => navigator.pop(result);

  // ── Snackbar / overlay ──
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  void showSnackBar(
    String message, {
    Duration duration = AppConstants.snackbarDuration,
    SnackBarAction? action,
  }) {
    scaffoldMessenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration,
          action: action,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void showErrorSnackBar(String message) {
    scaffoldMessenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: colorScheme.error,
          duration: AppConstants.snackbarDuration,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

// ══════════════════════════════════════════════
//  String Extensions
// ══════════════════════════════════════════════

extension StringExtensions on String {
  /// Capitalises the first character.
  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Title-cases every word.
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((w) => w.capitalized).join(' ');
  }

  /// Returns `null` if the string is empty, otherwise itself.
  String? get nullIfEmpty => isEmpty ? null : this;

  /// Truncates the string to [maxLength] and appends an ellipsis.
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}…';
  }

  /// Returns the initials (up to [count] characters) from the words.
  String initials([int count = 2]) {
    final words = trim().split(RegExp(r'\s+'));
    final buffer = StringBuffer();
    for (var i = 0; i < words.length && i < count; i++) {
      if (words[i].isNotEmpty) {
        buffer.write(words[i][0].toUpperCase());
      }
    }
    return buffer.toString();
  }

  /// Whether the string is a valid positive decimal number.
  bool get isValidAmount {
    if (isEmpty) return false;
    final parsed = double.tryParse(replaceAll(',', '.'));
    return parsed != null && parsed > 0;
  }

  /// Parses the string as a double, treating comma as decimal separator.
  double? toAmount() {
    if (isEmpty) return null;
    return double.tryParse(replaceAll(',', '.'));
  }
}

// ══════════════════════════════════════════════
//  DateTime Extensions
// ══════════════════════════════════════════════

extension DateTimeExtensions on DateTime {
  /// `10 Haziran 2026, Çarşamba`
  String get fullDate => Formatters.dateFull(this);

  /// `10 Haz 2026`
  String get mediumDate => Formatters.dateMedium(this);

  /// `10.06.2026`
  String get shortDate => Formatters.dateShort(this);

  /// `14:30`
  String get timeOnly => Formatters.time(this);

  /// `10 Haz 2026, 14:30`
  String get dateTimeFormatted => Formatters.dateTime(this);

  /// `Bugün`, `Dün`, or medium date.
  String get relative => Formatters.dateRelative(this);

  /// `Haziran 2026`
  String get monthYear => Formatters.monthYear(this);

  /// Whether this date is the same calendar day as [other].
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Whether this date is today.
  bool get isToday => isSameDay(DateTime.now());

  /// Whether this date is yesterday.
  bool get isYesterday =>
      isSameDay(DateTime.now().subtract(const Duration(days: 1)));

  /// Start of the day (00:00:00).
  DateTime get startOfDay => DateTime(year, month, day);

  /// End of the day (23:59:59.999).
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Start of the current month.
  DateTime get startOfMonth => DateTime(year, month);

  /// End of the current month.
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);
}

// ══════════════════════════════════════════════
//  Number Extensions
// ══════════════════════════════════════════════

extension NumExtensions on num {
  /// Formats as currency: `₺1.234,50`.
  String toCurrency([Currency currency = Currency.tl]) =>
      Formatters.currency(toDouble(), currency);

  /// Formats as compact currency: `₺1,2B`.
  String toCurrencyCompact([Currency currency = Currency.tl]) =>
      Formatters.currencyCompact(toDouble(), currency);

  /// Formats as a plain number with [decimalDigits].
  String toFormattedNumber({int decimalDigits = 2}) =>
      Formatters.number(toDouble(), decimalDigits: decimalDigits);

  /// Formats as a percentage: `75,5%`.
  String toPercentage({int decimalDigits = 1}) =>
      Formatters.percentage(toDouble(), decimalDigits: decimalDigits);

  /// Duration from milliseconds.
  Duration get ms => Duration(milliseconds: toInt());

  /// Duration from seconds.
  Duration get seconds => Duration(seconds: toInt());
}
