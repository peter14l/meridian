import 'package:flutter/material.dart';

class GlowCard extends StatelessWidget {
  final Widget child;
  final bool isAI;
  final VoidCallback? onTap;
  final Color? color;

  const GlowCard({
    super.key,
    required this.child,
    this.isAI = true,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final outerGlowColor = isDark 
        ? theme.colorScheme.primary.withValues(alpha: 0.3) 
        : theme.colorScheme.primary.withValues(alpha: 0.2);
        
    final gradientStart = theme.colorScheme.primary;
    final gradientEnd = theme.colorScheme.tertiary;
    final currentBackground = color ?? theme.colorScheme.surfaceContainer;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: currentBackground,
          borderRadius: BorderRadius.circular(24), // Extra-Large
          boxShadow: isAI ? [
            BoxShadow(
              color: outerGlowColor,
              blurRadius: isDark ? 24 : 16,
              spreadRadius: -4,
            ),
          ] : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // ShaderMask for Gradient Border
              if (isAI)
                Positioned.fill(
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [
                          gradientStart, 
                          gradientEnd, 
                          theme.colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcOver,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(width: 2.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              if (isAI && isDark) // Inner Glow for Dark Mode
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(alpha: 0.15),
                          blurRadius: 12,
                          spreadRadius: 0,
                          blurStyle: BlurStyle.inner,
                        ),
                      ],
                    ),
                  ),
                ),
              // Content Card
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
