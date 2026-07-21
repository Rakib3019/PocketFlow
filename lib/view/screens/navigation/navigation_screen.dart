import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/navigation_viewmodel.dart';
import '../../widgets/navigation/custom_bottom_nav.dart';
import '../categories/categories_screen.dart';
import '../home/home_screen.dart';
import '../settings/settings_screen.dart';
import '../statistics/statistics_screen.dart';
import '../transactions/transactions_screen.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationVM = context.watch<NavigationViewModel>();

    final pages = [
      HomeScreen(),
      TransactionsScreen(),
      StatisticsScreen(),
      CategoriesScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: navigationVM.currentIndex,
        children: pages,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Open Add Transaction Bottom Sheet
        },
        child: const Icon(Icons.add),
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}