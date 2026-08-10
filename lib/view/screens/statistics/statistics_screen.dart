import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pocket_mate/viewmodels/loan/loan_viewmodel.dart';
import '../../../viewmodels/budget_viewmodel.dart';
import '../../../viewmodels/transaction/transaction_viewmodel.dart';

import 'package:pocket_mate/view/widgets/statistics/statistics_loan_overview_card.dart';
import 'package:pocket_mate/view/widgets/statistics/statistics_monthly_overview_chart.dart';
import '../../widgets/statistics/statistic_weekly_activity_card.dart';
import '../../widgets/statistics/statistics_app_bar.dart';
import '../../widgets/statistics/statistics_expense_breakdown_card.dart';
import '../../widgets/statistics/statistics_monthly_budget_card.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionVM = context.watch<TransactionViewModel>();
    final budgetVM = context.watch<BudgetViewModel>();
    final loanVM= context.watch<LoanViewModel>();


/// Expense Category Data
    final categoryData = transactionVM.expenseCategoryData;

/// Sort highest -> lowest
    final sorted = categoryData.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

/// Top 4 Categories
    final topCategories = sorted.take(4).toList();

/// Remaining Categories
    final others = sorted.skip(4).fold<double>(
      0.0,
          (sum, item) => sum + item.value,
    );

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

/// App Bar
              const StatisticsAppBar(),

              const SizedBox(height: 24),

/// Expense Breakdown
              ExpenseBreakdownCard(
                categories: transactionVM.topExpenseCategories,
                others: transactionVM.otherExpenseAmount,
                totalExpense: transactionVM.totalExpenseForChart,
              ),

              const SizedBox(height: 24),

///monthly overview
              MonthlyOverviewChart(
                income: transactionVM.monthlyIncomeData,
                expense: transactionVM.monthlyExpenseData,
                budget: budgetVM.monthlyBudgetData,
              ),

              const SizedBox(height: 24),

///weekly activity
              WeeklyActivityCard(
                weeklyExpense: transactionVM.weeklyExpenseData,
              ),

              const SizedBox(height: 24),

///monthly budget usage
              MonthlyBudgetCard(
                monthlyBudget: budgetVM.monthlyBudgetData,
                monthlyExpense: transactionVM.monthlyExpenseData,
              ),

              const SizedBox(height: 24),
///loan overview
              StatisticsLoanOverviewCard(
                borrowed: loanVM.activeBorrowed,
                lent: loanVM.activeLent,
                active: loanVM.activeLoans,
                paid: loanVM.paidLoans,
                monthlyBorrowed: loanVM.monthlyBorrowedData,
                monthlyLent: loanVM.monthlyLentData,
              ),

              const SizedBox(height: 24),

            ],
          ),
        ),
      ),
    );
  }
}