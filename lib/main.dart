import 'package:flutter/material.dart';
import 'package:pocket_mate/viewmodels/add_transaction_viewmodel.dart';
import 'package:pocket_mate/viewmodels/navigation_viewmodel.dart';
import 'package:pocket_mate/viewmodels/transaction_viewmodel.dart';
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

        ChangeNotifierProvider(
          create: (_) => TransactionViewModel(),
        ),

        ChangeNotifierProvider(
            create: (_) =>NavigationViewModel(),
        ),

        ChangeNotifierProvider(
          create: (_) => AddTransactionViewModel(),
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