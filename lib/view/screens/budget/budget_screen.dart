import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/budget_viewmodel.dart';
import '../../../viewmodels/transaction_viewmodel.dart';

import '../../widgets/budget/budget_app_bar.dart';
import '../../widgets/budget/budget_balance_card.dart';
import '../../widgets/budget/budget_summary_card.dart';
import '../../widgets/budget/budget_progress_card.dart';
import '../../widgets/budget/budget_insight_card.dart';
import '../../widgets/budget/edit_budget_dialog.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetVM = context.watch<BudgetViewModel>();
    final transactionVM = context.watch<TransactionViewModel>();

    final expense = transactionVM.totalExpense;

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
///budget appbar
              const BudgetAppBar(),

              const SizedBox(height: 24),
///budget balance card
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => const EditBudgetDialog(),
                  );
                },
                child: BudgetBalanceCard(
                  amount: budgetVM.budgetAmount,
                ),
              ),

              const SizedBox(height: 24),
///Card Row
              Row(
                children: [

                  Expanded(
                    child: BudgetSummaryCard(
                      title: "Spent",
                      amount: expense,
                      icon: Icons.trending_down,
                      color: const Color(0xffFF6B6B),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: BudgetSummaryCard(
                      title: "Remaining",
                      amount: budgetVM.remainingBudget(expense),
                      icon: Icons.account_balance_wallet,
                      color: const Color(0xff7ED6A7),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: BudgetSummaryCard(
                      title: "Usage",
                      amount:
                      budgetVM.usedPercentage(expense) * 100,
                      icon: Icons.pie_chart,
                      color: const Color(0xff6C63FF),
                      isPercent: true,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
///budget progress
              BudgetProgressCard(
                budget: budgetVM.budgetAmount,
                expense: expense,
              ),

              const SizedBox(height: 24),
///budget Insights
              BudgetInsightCard(
                budget: budgetVM.budgetAmount,
                expense: expense,
              ),

              const SizedBox(height: 24),


            ],
          ),
        ),
      ),
    );
  }
}