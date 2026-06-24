import 'package:flutter/material.dart';

/// Reusable bottom sheet with rounded top corners, drag handle, and backdrop blur.
///
/// Use the static [show] method to present the sheet with a slide-up animation.
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.showDragHandle = true,
    this.padding,
  });

  final Widget child;
  final String? title;
  final bool showDragHandle;
  final EdgeInsetsGeometry? padding;

  /// Shows the bottom sheet with a slide-up animation and backdrop blur.
  ///
  /// Returns the value passed to [Navigator.pop] when the sheet is dismissed.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool showDragHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
    bool isDraggable = false,
    EdgeInsetsGeometry? padding,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0xFF201B11).withValues(alpha: 0.3),
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 300),
      ),
      builder: (context) {
        if (isDraggable) {
          return DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            expand: false,
            snap: true,
            snapSizes: const [0.5, 0.9],
            builder: (context, scrollController) => _BottomSheetContent(
              title: title,
              showDragHandle: showDragHandle,
              padding: padding,
              scrollController: scrollController,
              child: child,
            ),
          );
        }

        return _BottomSheetContent(
          title: title,
          showDragHandle: showDragHandle,
          padding: padding,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _BottomSheetContent(
      title: title,
      showDragHandle: showDragHandle,
      padding: padding,
      child: child,
    );
  }
}


/// The actual bottom sheet card with drag handle, optional title, and content.
class _BottomSheetContent extends StatelessWidget {
  const _BottomSheetContent({
    required this.child,
    this.title,
    this.showDragHandle = true,
    this.padding,
    this.scrollController,
  });

  final Widget child;
  final String? title;
  final bool showDragHandle;
  final EdgeInsetsGeometry? padding;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.12),
              offset: Offset(0, -8),
              blurRadius: 30,
            ),
          ],
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showDragHandle) ...[
                  const SizedBox(height: 12),
                  _DragHandle(),
                ],
                if (title != null) ...[
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title!,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onSurface,
                              height: 26 / 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Padding(
                  padding: padding ??
                      const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: 24,
                      ),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The small drag handle indicator at the top of the sheet.
class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 48,
        height: 6,
        decoration: BoxDecoration(
          color: const Color(0xFF5F5E5E).withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
    );
  }
}
