import 'package:flutter/material.dart';

class WattMateLogo extends StatelessWidget {
  final double size;
  final bool showText;

  const WattMateLogo({super.key, this.size = 120, this.showText = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo Icon
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2563EB), // Blue 600
                Color(0xFF1D4ED8), // Blue 700
              ],
            ),
            borderRadius: BorderRadius.circular(size * 0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Light bulb body
              Container(
                width: size * 0.45,
                height: size * 0.45,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF67E8F9), // Cyan 300
                      Color(0xFF06B6D4), // Cyan 600
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),

              // Light bulb base
              Positioned(
                bottom: size * 0.3,
                child: Column(
                  children: [
                    Container(
                      width: size * 0.2,
                      height: size * 0.06,
                      decoration: BoxDecoration(
                        color: const Color(0xFF06B6D4).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      width: size * 0.16,
                      height: size * 0.04,
                      decoration: BoxDecoration(
                        color: const Color(0xFF06B6D4).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      width: size * 0.12,
                      height: size * 0.03,
                      decoration: BoxDecoration(
                        color: const Color(0xFF06B6D4).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),

              // Lightning bolt
              CustomPaint(
                size: Size(size * 0.25, size * 0.35),
                painter: LightningBoltPainter(),
              ),

              // Shine effect
              Positioned(
                top: size * 0.32,
                left: size * 0.36,
                child: Transform.rotate(
                  angle: -0.5,
                  child: Container(
                    width: size * 0.08,
                    height: size * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(size * 0.04),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        if (showText) ...[
          const SizedBox(height: 16),
          Text(
            'WattMate',
            style: TextStyle(
              fontSize: size * 0.25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class LightningBoltPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFCD34D), // Yellow 300
          Color(0xFFF59E0B), // Yellow 500
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();

    // Lightning bolt shape
    path.moveTo(size.width * 0.6, 0);
    path.lineTo(size.width * 0.2, size.height * 0.45);
    path.lineTo(size.width * 0.45, size.height * 0.45);
    path.lineTo(size.width * 0.4, size.height);
    path.lineTo(size.width * 0.8, size.height * 0.55);
    path.lineTo(size.width * 0.55, size.height * 0.55);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
