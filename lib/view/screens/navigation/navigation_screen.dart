import 'package:flutter/material.dart';
import 'package:pocket_mate/view/screens/history/history_screen.dart';
import 'package:pocket_mate/view/screens/loan/loan_screen.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/transaction/add_transaction_viewmodel.dart';
import '../../../viewmodels/navigation_viewmodel.dart';
import '../../widgets/loan/add_loan_bottom_sheet.dart';
import '../../widgets/navigation/custom_bottom_nav.dart';
import '../../widgets/transaction/add_transaction_bottom_sheet.dart';
import '../home/home_screen.dart';
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
      LoanScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: navigationVM.currentIndex,
        children: pages,
      ),

///floating button
      floatingActionButton: navigationVM.currentIndex == 3
          ? FloatingActionButton(
        heroTag: "addLoan",
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 8,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const AddLoanBottomSheet(),
          );
        },
        child: const Icon(
          Icons.payment_rounded,
          color: Colors.white,
          size: 30,
        ),
      )
          : FloatingActionButton(
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
          color: Colors.white,
          size: 32,
        ),
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniEndFloat,

      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}