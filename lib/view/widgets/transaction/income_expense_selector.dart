import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/transaction/add_transaction_viewmodel.dart';

class IncomeExpenseSelector extends StatelessWidget {
  const IncomeExpenseSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddTransactionViewModel>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final double pillWidth = (constraints.maxWidth - 8) / 2;

        return Container(
          height: 60,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              /// Sliding Button
              AnimatedAlign(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                alignment:
                vm.isIncome ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: pillWidth,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: vm.isIncome
                        ? const Color(0xFF22C55E) // Green for Income
                        : const Color(0xFFEF4444), // Red for Expense
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.grey.shade300,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (vm.isIncome
                            ? const Color(0xFF22C55E)
                            : const Color(0xFFEF4444))
                            .withOpacity(0.35),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                ),
              ),

              /// Buttons
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        context
                            .read<AddTransactionViewModel>()
                            .changeTransactionType(false);
                      },
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                          style: TextStyle(
                            color: !vm.isIncome ? Colors.white : Colors.grey.shade600,
                            fontSize: 20,
                            fontWeight: !vm.isIncome
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                          child: const Text("Expense"),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        context
                            .read<AddTransactionViewModel>()
                            .changeTransactionType(true);
                      },
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                          style: TextStyle(
                            color: vm.isIncome ? Colors.white : Colors.grey.shade600,
                            fontSize: 20,
                            fontWeight: vm.isIncome
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                          child: const Text("Income"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}