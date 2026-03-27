import 'package:flutter/material.dart';

class GlowCard extends StatelessWidget {
  final Widget child;
  final bool isAI;
  final VoidCallback? onTap;

  const GlowCard({
    super.key,
    required this.child,
    this.isAI = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final outerGlowColor = isDark 
        ? const Color(0xFF818CF8).withValues(alpha: 0.4) 
        : const Color(0xFF6366F1).withValues(alpha: 0.25);
        
    final gradientStart = isDark ? const Color(0xFF818CF8) : const Color(0xFF6366F1);
    final gradientEnd = isDark ? const Color(0xFFC084FC) : const Color(0xFFA855F7);
    final currentBackground = isDark ? const Color(0xFF1A1A2E) : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: currentBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isAI ? [
            BoxShadow(
              color: outerGlowColor,
              blurRadius: isDark ? 18 : 14,
              spreadRadius: 0,
            ),
          ] : null,
        ),
        foregroundDecoration: isAI ? BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1.5,
            color: Colors.transparent, // the gradient border usually needs a CustomPainter or ShaderMask
          ),
        ) : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // ShaderMask for Gradient Border
              if (isAI)
                Positioned.fill(
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: isDark 
                            ? [gradientStart, gradientEnd, const Color(0xFF2DD4BF)]
                            : [gradientStart, gradientEnd],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcOver,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1.5, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              if (isAI && isDark) // Inner Glow for Dark Mode
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                          blurRadius: 8,
                          spreadRadius: 0,
                          blurStyle: BlurStyle.inner,
                        ),
                      ],
                    ),
                  ),
                ),
              // Content Card
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
