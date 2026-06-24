import 'package:flutter/material.dart';

/// Primary action button with golden background and press-scale effect.
///
/// Displays a loading indicator when [isLoading] is true.
/// Full-width by default; set [fullWidth] to false to shrink-wrap.
class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    this.onPressed,
    this.child,
    this.label,
    this.isLoading = false,
    this.fullWidth = true,
    this.height = 52,
    this.borderRadius = 16,
  }) : assert(child != null || label != null,
            'Either child or label must be provided');

  final VoidCallback? onPressed;
  final Widget? child;
  final String? label;
  final bool isLoading;
  final bool fullWidth;
  final double height;
  final double borderRadius;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  bool get _isEnabled => widget.onPressed != null && !widget.isLoading;

  void _onTapDown(TapDownDetails details) {
    if (_isEnabled) _scaleController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    if (_isEnabled) _scaleController.reverse();
  }

  void _onTapCancel() {
    if (_isEnabled) _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).colorScheme.primaryContainer;
    final foregroundColor = Theme.of(context).colorScheme.onPrimaryContainer;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: SizedBox(
        width: widget.fullWidth ? double.infinity : null,
        height: widget.height,
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: ElevatedButton(
            onPressed: _isEnabled ? widget.onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              disabledBackgroundColor: buttonColor.withValues(alpha: 0.5),
              foregroundColor: foregroundColor,
              disabledForegroundColor: foregroundColor.withValues(alpha: 0.7),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            child: widget.isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
                    ),
                  )
                : widget.child ??
                    Text(
                      widget.label!,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 24 / 16,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}

/// Secondary action button with white background and golden border.
class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    this.onPressed,
    this.child,
    this.label,
    this.isLoading = false,
    this.fullWidth = true,
    this.height = 52,
    this.borderRadius = 16,
  }) : assert(child != null || label != null,
            'Either child or label must be provided');

  final VoidCallback? onPressed;
  final Widget? child;
  final String? label;
  final bool isLoading;
  final bool fullWidth;
  final double height;
  final double borderRadius;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  bool get _isEnabled => widget.onPressed != null && !widget.isLoading;

  void _onTapDown(TapDownDetails details) {
    if (_isEnabled) _scaleController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    if (_isEnabled) _scaleController.reverse();
  }

  void _onTapCancel() {
    if (_isEnabled) _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: SizedBox(
        width: widget.fullWidth ? double.infinity : null,
        height: widget.height,
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: OutlinedButton(
            onPressed: _isEnabled ? widget.onPressed : null,
            style: OutlinedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: primaryColor,
              disabledForegroundColor: primaryColor.withValues(alpha: 0.5),
              elevation: 0,
              side: BorderSide(
                color: _isEnabled
                    ? primaryColor
                    : primaryColor.withValues(alpha: 0.5),
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            child: widget.isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  )
                : widget.child ??
                    Text(
                      widget.label!,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 24 / 16,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}

/// Small transparent icon button with primary color.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 40,
    this.iconSize = 24,
    this.color,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final Color? color;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: size,
      height: size,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: iconSize),
        color: iconColor,
        padding: EdgeInsets.zero,
        tooltip: tooltip,
        style: IconButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
