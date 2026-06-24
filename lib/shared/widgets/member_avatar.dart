import 'package:flutter/material.dart';

/// Circular avatar displaying member initials with optional indicators.
///
/// Two size variants: default (56) and small (32).
/// Supports an online indicator dot and a notification count badge.
class MemberAvatar extends StatelessWidget {
  const MemberAvatar({
    super.key,
    required this.name,
    this.size = MemberAvatarSize.regular,
    this.backgroundColor,
    this.textColor,
    this.showOnlineIndicator = false,
    this.notificationCount,
    this.border,
  });

  final String name;
  final MemberAvatarSize size;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showOnlineIndicator;
  final int? notificationCount;
  final BoxBorder? border;

  /// Extracts up to 2 initials from the name.
  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  double get _diameter {
    return switch (size) {
      MemberAvatarSize.regular => 56.0,
      MemberAvatarSize.small => 32.0,
    };
  }

  double get _fontSize {
    return switch (size) {
      MemberAvatarSize.regular => 20.0,
      MemberAvatarSize.small => 12.0,
    };
  }

  double get _onlineDotSize {
    return switch (size) {
      MemberAvatarSize.regular => 14.0,
      MemberAvatarSize.small => 8.0,
    };
  }

  double get _badgeSize {
    return switch (size) {
      MemberAvatarSize.regular => 20.0,
      MemberAvatarSize.small => 14.0,
    };
  }

  @override
  Widget build(BuildContext context) {
    const defaultBg = Color(0xFFEDE1D1); // surfaceContainerHighest
    const defaultText = Color(0xFF504533); // onSurfaceVariant

    final bg = backgroundColor ?? defaultBg;
    final fg = textColor ?? defaultText;

    final bool showBadge =
        notificationCount != null && notificationCount! > 0;

    return SizedBox(
      width: _diameter,
      height: _diameter,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main avatar circle
          Container(
            width: _diameter,
            height: _diameter,
            decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
              border: border,
            ),
            alignment: Alignment.center,
            child: Text(
              _initials,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: _fontSize,
                fontWeight: FontWeight.w700,
                color: fg,
                height: 1,
              ),
            ),
          ),

          // Online indicator (bottom-right green dot)
          if (showOnlineIndicator)
            Positioned(
              bottom: -(_onlineDotSize / 4),
              right: -(_onlineDotSize / 4),
              child: Container(
                width: _onlineDotSize,
                height: _onlineDotSize,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).colorScheme.surface, width: 2),
                ),
              ),
            ),

          // Notification badge (top-right red circle)
          if (showBadge)
            Positioned(
              top: -(_badgeSize / 3),
              right: -(_badgeSize / 3),
              child: Container(
                constraints: BoxConstraints(
                  minWidth: _badgeSize,
                  minHeight: _badgeSize,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE53935),
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).colorScheme.surface, width: 1.5),
                ),
                alignment: Alignment.center,
                child: Text(
                  notificationCount! > 99 ? '99+' : '$notificationCount',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: size == MemberAvatarSize.regular ? 10 : 8,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onError,
                    height: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Size variants for [MemberAvatar].
enum MemberAvatarSize {
  /// 56×56 pixels
  regular,

  /// 32×32 pixels
  small,
}
