import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocket_mate/services/storage_service.dart';
import 'package:pocket_mate/theme/app_colors.dart';
import 'package:pocket_mate/view/screens/home/home_screen.dart';
import 'package:pocket_mate/view/screens/navigation/navigation_screen.dart';
import 'package:pocket_mate/view/screens/profile/profile_setup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with
    SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(
      begin: .8,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
    checkUser();

  }

  Future<void> checkUser() async {
    await Future.delayed(const Duration(seconds: 2));

    final user = await StorageService.loadUser();

    if (!mounted) return;

    if (user != null && user.isProfileCompleted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const NavigationScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfileSetupScreen(),
        ),
      );
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  Widget buildDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: .4, end: 1),
      duration: Duration(milliseconds: 600 + (index * 200)),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(value),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [

          /// Purple Circle
          Positioned(
            top: -120,
            right: -100,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
            ),
          ),

          /// Mint Circle
          Positioned(
            bottom: -100,
            left: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary,
              ),
            ),
          ),

          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Image.asset(
                      "assets/images/logo.png",
                      width: 120,
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      "Pocket Mate",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Spend Smarter.\nLive Better.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 60),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildDot(0),
                        buildDot(1),
                        buildDot(2),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}