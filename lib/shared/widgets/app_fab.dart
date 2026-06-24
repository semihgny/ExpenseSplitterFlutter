import 'package:flutter/material.dart';

/// Custom Floating Action Button with golden background and press-scale effect.
///
/// Uses rounded-xl (radius 16) instead of circular shape.
/// Two sizes: default (56) and large (64).
class AppFab extends StatefulWidget {
  const AppFab({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.isLarge = false,
    this.tooltip,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final bool isLarge;
  final String? tooltip;

  @override
  State<AppFab> createState() => _AppFabState();
}

class _AppFabState extends State<AppFab> with SingleTickerProviderStateMixin {
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

  bool get _isEnabled => widget.onPressed != null;

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
    const primaryContainer = Color(0xFFF0AE03);
    final size = widget.isLarge ? 64.0 : 56.0;
    final iconSize = widget.isLarge ? 28.0 : 24.0;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Semantics(
          button: true,
          label: widget.tooltip,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: _isEnabled
                  ? primaryContainer
                  : primaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF0AE03).withValues(alpha: 0.3),
                  offset: const Offset(0, 8),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Icon(
              widget.icon,
              color: Colors.white,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
