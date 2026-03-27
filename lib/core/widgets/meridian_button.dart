import 'package:flutter/material.dart';

enum MeridianButtonVariant { primary, secondary, ghost }

class MeridianButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final MeridianButtonVariant variant;
  final bool isLoading;
  final IconData? icon;

  const MeridianButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = MeridianButtonVariant.primary,
    this.isLoading = false,
    this.icon,
  });

  @override
  State<MeridianButton> createState() => _MeridianButtonState();
}

class _MeridianButtonState extends State<MeridianButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    // Spring Physics-like effect
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const ElasticOutCurve(0.8), // Expressive Spring
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    ButtonStyle buttonStyle;
    
    switch (widget.variant) {
      case MeridianButtonVariant.primary:
        buttonStyle = FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Large
          textStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        );
        break;
      case MeridianButtonVariant.secondary:
        buttonStyle = FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.secondaryContainer,
          foregroundColor: theme.colorScheme.onSecondaryContainer,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Large
          textStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        );
        break;
      case MeridianButtonVariant.ghost:
        buttonStyle = TextButton.styleFrom(
          foregroundColor: theme.colorScheme.primary,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Large
          textStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        );
        break;
    }

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.isLoading ? null : widget.onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.isLoading 
          ? Container(
              height: 56,
              decoration: BoxDecoration(
                color: widget.variant == MeridianButtonVariant.primary 
                  ? theme.colorScheme.primary 
                  : theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: widget.variant == MeridianButtonVariant.primary 
                      ? theme.colorScheme.onPrimary 
                      : theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            )
          : (widget.variant == MeridianButtonVariant.ghost 
              ? TextButton.icon(
                  onPressed: widget.onPressed,
                  style: buttonStyle,
                  icon: widget.icon != null ? Icon(widget.icon, size: 20) : const SizedBox.shrink(),
                  label: Text(widget.label),
                )
              : FilledButton.icon(
                  onPressed: widget.onPressed,
                  style: buttonStyle,
                  icon: widget.icon != null ? Icon(widget.icon, size: 20) : const SizedBox.shrink(),
                  label: Text(widget.label),
                )),
      ),
    );
  }
}
