import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/budget_viewmodel.dart';

class EditBudgetDialog extends StatefulWidget {
  const EditBudgetDialog({super.key});

  @override
  State<EditBudgetDialog> createState() => _EditBudgetDialogState();
}

class _EditBudgetDialogState extends State<EditBudgetDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    final budget =
        context.read<BudgetViewModel>().budgetAmount;

    controller = TextEditingController(
      text: budget == 0 ? "" : budget.toStringAsFixed(0),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final budgetVM = context.read<BudgetViewModel>();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),

      title: const Row(
        children: [
          Icon(
            Icons.account_balance_wallet_rounded,
            color: Color(0xff6C63FF),
          ),

          SizedBox(width: 10),

          Text("Monthly Budget"),
        ],
      ),

      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Enter budget",

          prefixText: "৳ ",

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff6C63FF),
            foregroundColor: Colors.white,
          ),
          onPressed: () async {
            final amount =
            double.tryParse(controller.text);

            if (amount == null || amount <= 0) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    "Please enter a valid budget.",
                  ),
                ),
              );

              return;
            }

            await budgetVM.saveBudget(amount);

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}