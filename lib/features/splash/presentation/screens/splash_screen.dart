import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300), // Reduced from 500ms
      vsync: this,
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    Future.delayed(const Duration(milliseconds: 800), () {
      // Reduced from 2 seconds
      if (mounted) {
        context.go('/sources');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: FadeTransition(
          opacity: _opacity,
          child: Image.asset(
            'assets/images/watchflix_logo.png',
            width: 150,
            height: 150,
            errorBuilder: (context, error, stackTrace) {
              // Temporary fallback while setting up the logo
              return const FlutterLogo(
                size: 150,
                style: FlutterLogoStyle.horizontal,
              );
            },
          ),
        ),
      ),
    );
  }
}
