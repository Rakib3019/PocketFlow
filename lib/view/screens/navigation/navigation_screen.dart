import 'package:flutter/material.dart';
import 'package:pocket_mate/view/screens/history/history_screen.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/add_transaction_viewmodel.dart';
import '../../../viewmodels/navigation_viewmodel.dart';
import '../../widgets/navigation/custom_bottom_nav.dart';
import '../../widgets/transaction/add_transaction_bottom_sheet.dart';
import '../categories/categories_screen.dart';
import '../home/home_screen.dart';
import '../settings/settings_screen.dart';
import '../statistics/statistics_screen.dart';



class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationVM = context.watch<NavigationViewModel>();

    final pages = [
      HomeScreen(),
      HistoryScreen(),
      StatisticsScreen(),
      CategoriesScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: navigationVM.currentIndex,
        children: pages,
      ),

///floating button
      floatingActionButton: FloatingActionButton(
        heroTag: "addTransaction",
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 8,
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const AddTransactionBottomSheet(),
          );

          if (context.mounted) {
            context.read<AddTransactionViewModel>().reset();
          }
        },
        child: const Icon(
          Icons.add_rounded,
          size: 32,
          color: Colors.white,
        ),
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniEndFloat,

      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}