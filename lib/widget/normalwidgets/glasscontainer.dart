import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/context_extension.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;

  const GlassContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final double screenw = context.w;
    // final double screenh = context.h;
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: screenw * 0.9,
          // height: screenh * 0.5,
          decoration: BoxDecoration(
            // Instead of Colors.white.withOpacity(0.2)
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              // Instead of .withOpacity(0.3)
              color: Colors.white.withValues(alpha: 0.28),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
