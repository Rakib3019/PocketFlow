import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/default_categories.dart';
import '../../../utils/transaction_filter.dart';
import '../../../viewmodels/transaction/add_transaction_viewmodel.dart';
import '../../../viewmodels/transaction/transaction_viewmodel.dart';

import '../../widgets/transaction/transaction_app_bar.dart';
import '../../widgets/transaction/transaction_search_bar.dart';
import '../../widgets/home/transaction_tile.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController searchController = TextEditingController();

  int selectedTypeFilter = 0;
  int selectedDateFilter = 1;

  final List<String> typeFilters = [
    "All",
    "Money Added",
    "Expense",
  ];

  final List<String> dateFilters = [
    "This Week",
    "This Month",
    "This Year",
  ];

  @override
  void dispose() {
    searchController.dispose();
    return super.dispose();
  }

  Widget _buildFilterChip({
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xff6C63FF)
              : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected
                ? const Color(0xff6C63FF)
                : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color:
              selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactionVM = context.watch<TransactionViewModel>();
    final addVM = context.watch<AddTransactionViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),

          child: Column(
            children: [
              const HistoryAppBar(),

              const SizedBox(height: 20),

              HistorySearchBar(
                controller: searchController,
                onChanged: (value) {
                  context
                      .read<TransactionViewModel>()
                      .searchTransactions(value);
                },
              ),

              const SizedBox(height: 20),

/// Transaction Type Filters
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: typeFilters.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return _buildFilterChip(
                      text: typeFilters[index],
                      selected:
                      selectedTypeFilter == index,
                      onTap: () {
                        setState(() {
                          selectedTypeFilter = index;
                        });

                        final vm = context
                            .read<TransactionViewModel>();

                        switch (index) {
                          case 0:
                            vm.changeTypeFilter(
                              TransactionTypeFilter.all,
                            );
                            break;

                          case 1:
                            vm.changeTypeFilter(
                              TransactionTypeFilter
                                  .income,
                            );
                            break;

                          case 2:
                            vm.changeTypeFilter(
                              TransactionTypeFilter
                                  .expense,
                            );
                            break;
                        }
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 14),

/// Date Filters
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: dateFilters.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return _buildFilterChip(
                      text: dateFilters[index],
                      selected:
                      selectedDateFilter == index,
                      onTap: () {
                        setState(() {
                          selectedDateFilter = index;
                        });

                        final vm = context
                            .read<TransactionViewModel>();

                        switch (index) {
                          case 0:
                            vm.changeFilter(
                              TransactionFilter.thisWeek,
                            );
                            break;

                          case 1:
                            vm.changeFilter(
                              TransactionFilter
                                  .thisMonth,
                            );
                            break;

                          case 2:
                            vm.changeFilter(
                              TransactionFilter.thisYear,
                            );
                            break;
                        }
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: transactionVM
                    .filteredTransactions.isEmpty
                    ? const Center(
                  child: Text(
                    "No Transactions Found",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                )
                    : ListView(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          bottom: 12),
                      child: Text(
                        "TRANSACTIONS",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight:
                          FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),

                    ...transactionVM.filteredTransactions.map((transaction) =>
                          TransactionTile(
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
                                : const Color(0xffFF6B6B),
                            isIncome: transaction.isIncome,
                            note: transaction.note,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}