import 'package:flutter/material.dart';
import 'package:pocket_mate/theme/app_theme.dart';
import 'package:pocket_mate/view/screens/home/home_screen.dart';
import 'package:pocket_mate/view/screens/splash/splash_screen.dart';

void main() {
  runApp(const PocketFlow());
}

class PocketFlow extends StatelessWidget {
  const PocketFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PocketFlow",
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
