import 'package:flutter/material.dart';

import 'edit_budget_dialog.dart';

class BudgetAppBar extends StatelessWidget {
  const BudgetAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
 /// Back Button
        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
            ),
          ),
        ),

        const Spacer(),

        const Text(
          "Monthly Budget",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Spacer(),
        const SizedBox(width: 24),

      ],
    );
  }
}