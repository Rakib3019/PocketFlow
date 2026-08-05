import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/loan_filter.dart';
import '../../../viewmodels/loan/loan_viewmodel.dart';

class LoanFilterChips extends StatelessWidget {
  const LoanFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoanViewModel>();

    final filters = [
      ("All", LoanFilter.all),
      ("Borrowed", LoanFilter.borrowed),
      ("Lent", LoanFilter.lent),
      ("Active", LoanFilter.active),
      ("Paid", LoanFilter.paid),
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final item = filters[index];
          final selected = vm.filter == item.$2;

          return GestureDetector(
            onTap: () {
              vm.changeFilter(item.$2);
            },
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
              child: Text(
                item.$1,
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}