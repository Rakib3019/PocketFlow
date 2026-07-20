import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'view/screens/splash/splash_screen.dart';
import 'viewmodels/user_viewmodel.dart';

void main() {
  runApp(const PocketMate());
}

class PocketMate extends StatelessWidget {
  const PocketMate({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserViewModel()..loadUser(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PocketMate',
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}