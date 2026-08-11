import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/default_categories.dart';
import '../../../viewmodels/budget_viewmodel.dart';
import '../../../viewmodels/transaction/transaction_viewmodel.dart';
import '../../widgets/home/balance_card.dart';
import '../../widgets/home/budget_progress_card.dart';
import '../../widgets/home/home_app_bar.dart';
import '../../widgets/home/summary_card.dart';
import '../../widgets/home/transaction_tile.dart';
import '../budget/budget_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionVM = context.watch<TransactionViewModel>();
    final budgetVM = context.watch<BudgetViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
///appbar
              const HomeAppBar(),
              const SizedBox(height: 24),
///balance card
              BalanceCard(
                balance: transactionVM.currentBalance,
              ),
              const SizedBox(height: 24),

///summery card
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      title: "Money Added",
                      amount: transactionVM.totalMoneyAdded,
                      icon: Icons.trending_up,
                      color: const Color(0xff7ED6A7),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: SummaryCard(
                      title: "Expense",
                      amount: transactionVM.totalExpense,
                      icon: Icons.trending_down,
                      color: const Color(0xffFF6B6B),
                    ),
                  ),

                  const SizedBox(width: 14),

         /*         Expanded(
                    child: SummaryCard(
                      title: "Balance",
                      amount: transactionVM.currentBalance,
                      icon: Icons.account_balance_wallet_outlined,
                      color: Colors.black,
                    ),
                  ),*/
                ],
              ),
              const SizedBox(height: 24),

///monthly budget
              InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BudgetScreen(),
                    ),
                  );
                },

///progress card
                child: BudgetProgressCard(
                  totalExpense: transactionVM.currentMonthExpense,
                  monthlyBudget: budgetVM.budgetAmount,
                ),
              ),
              const SizedBox(height: 24),
///recent transactions
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Recent Transactions",
                    style: TextStyle(
                    fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                  ),),
                ],
              ),


              const SizedBox(height:8),
              if (transactionVM.recentTransactions.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    "No transactions yet",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactionVM.recentTransactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactionVM.recentTransactions[index];

                    return TransactionTile(
                      title: DefaultCategories.getCategoryName(
                        transaction.categoryId,
                      ),
                      category: transaction.paymentMethod,
                      amount: transaction.amount,
                      date: transaction.date,
                      icon: transaction.isIncome
                          ? Icons.account_balance_wallet_rounded
                          : Icons.shopping_bag_rounded,
                      iconColor: transaction.isIncome
                          ? const Color(0xff7ED6A7)
                          : const Color(0xffFFB74D),
                      isIncome: transaction.isIncome,
                      note: transaction.note,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}