import 'package:flutter/material.dart';

class BudgetProgressCard extends StatelessWidget {
  final double budget;
  final double expense;

  const BudgetProgressCard({
    super.key,
    required this.budget,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final progress = budget == 0
        ? 0.0
        : (expense / budget).clamp(0.0, 1.0);

    Color progressColor;

    if (progress < .5) {
      progressColor = const Color(0xff7ED6A7);
    } else if (progress < .8) {
      progressColor = const Color(0xffFFD166);
    } else {
      progressColor = const Color(0xffFF6B6B);
    }

    final remaining = budget - expense;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Budget Usage",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 700),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 12,
                  backgroundColor: Colors.grey.shade200,
                  valueColor:
                  AlwaysStoppedAnimation(progressColor),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [

              Text(
                "${(progress * 100).toStringAsFixed(0)}% Used",
                style: TextStyle(
                  color: progressColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "৳ ${expense.toStringAsFixed(0)} / ৳ ${budget.toStringAsFixed(0)}",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height:16),
/*
          Row(
            children: [

              Expanded(
                child: _infoCard(
                  title: "Spent",
                  value: "৳ ${expense.toStringAsFixed(0)}",
                  color: const Color(0xffFF6B6B),
                  icon: Icons.arrow_downward_rounded,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: _infoCard(
                  title: "Remaining",
                  value: remaining < 0
                      ? "৳ 0"
                      : "৳ ${remaining.toStringAsFixed(0)}",
                  color: const Color(0xff7ED6A7),
                  icon: Icons.account_balance_wallet,
                ),
              ),
            ],
          ),*/

          if (expense > budget) ...[
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xffFF6B6B).withOpacity(.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [

                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xffFF6B6B),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "Budget exceeded by ৳ ${(expense - budget).toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: Color(0xffFF6B6B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [

          Icon(
            icon,
            color: color,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}