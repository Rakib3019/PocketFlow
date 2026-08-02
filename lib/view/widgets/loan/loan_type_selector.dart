import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/loan/add_loan_viewmodel.dart';

class LoanTypeSelector extends StatelessWidget {
  const LoanTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddLoanViewModel>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(5),

      child: Row(
        children: [

          Expanded(
            child: GestureDetector(
              onTap: () => vm.changeLoanType(true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 48,
                decoration: BoxDecoration(
                  color: vm.isBorrowed
                      ? const Color(0xff6C63FF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    "Borrowed",
                    style: TextStyle(
                      color: vm.isBorrowed
                          ? Colors.white
                          : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: () => vm.changeLoanType(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 48,
                decoration: BoxDecoration(
                  color: !vm.isBorrowed
                      ? const Color(0xff6C63FF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    "Lent",
                    style: TextStyle(
                      color: !vm.isBorrowed
                          ? Colors.white
                          : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}