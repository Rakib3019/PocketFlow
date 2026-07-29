import 'package:flutter/material.dart';

class BudgetProgressCard extends StatelessWidget {
  final double monthlyBudget;
  final double totalExpense;

  const BudgetProgressCard({
    super.key,
    required this.monthlyBudget,
    required this.totalExpense,
  });

  @override
  Widget build(BuildContext context) {
    final double progress =
    monthlyBudget == 0 ? 0 : totalExpense / monthlyBudget;

    final int percentage = (progress * 100).round();
    final double remaining = monthlyBudget - totalExpense;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    strokeWidth: 10,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation(
                      Color(0xff6C63FF),
                    ),
                  ),
                  Center(
                    child: Text(
                      "$percentage%",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 24),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Monthly Budget",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "You've spent ৳${totalExpense.toStringAsFixed(0)} of your ৳${monthlyBudget.toStringAsFixed(0)} budget.",
                    style: const TextStyle(
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Remaining: ৳${remaining.toStringAsFixed(0)}",
                    style: const TextStyle(
                      color: Color(0xff6C63FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}