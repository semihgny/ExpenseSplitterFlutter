import 'package:flutter/material.dart';

/// Shows a positive amount badge with green tint background.
///
/// Displays the amount prefixed with '+' and the currency symbol.
class PositiveBadge extends StatelessWidget {
  const PositiveBadge({
    super.key,
    required this.amount,
    this.currencySymbol = '₺',
    this.fontSize = 12,
  });

  final double amount;
  final String currencySymbol;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    const greenColor = Color(0xFF4CAF50);

    return _BadgeContainer(
      backgroundColor: greenColor.withValues(alpha: 0.1),
      child: Text(
        '+$currencySymbol${amount.toStringAsFixed(2)}',
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: greenColor,
          height: 16 / 12,
        ),
      ),
    );
  }
}

/// Shows a negative amount badge with red tint background.
///
/// Displays the amount prefixed with '-' and the currency symbol.
class NegativeBadge extends StatelessWidget {
  const NegativeBadge({
    super.key,
    required this.amount,
    this.currencySymbol = '₺',
    this.fontSize = 12,
  });

  final double amount;
  final String currencySymbol;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    const redColor = Color(0xFFE53935);

    return _BadgeContainer(
      backgroundColor: redColor.withValues(alpha: 0.1),
      child: Text(
        '-$currencySymbol${amount.toStringAsFixed(2)}',
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: redColor,
          height: 16 / 12,
        ),
      ),
    );
  }
}

/// Shows a user name badge with primary container tint background.
class UserBadge extends StatelessWidget {
  const UserBadge({
    super.key,
    required this.name,
    this.fontSize = 12,
  });

  final String name;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    const primaryContainer = Color(0xFFF0AE03);
    const onPrimaryContainer = Color(0xFF624500);

    return _BadgeContainer(
      backgroundColor: primaryContainer.withValues(alpha: 0.15),
      child: Text(
        name,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: onPrimaryContainer,
          height: 16 / 12,
        ),
      ),
    );
  }
}

/// Generic status badge with configurable color.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.text,
    required this.color,
    this.fontSize = 12,
  });

  final String text;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return _BadgeContainer(
      backgroundColor: color.withValues(alpha: 0.1),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: color,
          height: 16 / 12,
        ),
      ),
    );
  }
}

/// Internal container shared by all badge variants.
class _BadgeContainer extends StatelessWidget {
  const _BadgeContainer({
    required this.backgroundColor,
    required this.child,
  });

  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: child,
    );
  }
}
