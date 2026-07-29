import 'package:flutter/material.dart';

class BudgetInsightCard extends StatelessWidget {
  final double budget;
  final double expense;

  const BudgetInsightCard({
    super.key,
    required this.budget,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    String title;
    String message;
    IconData icon;
    Color color;

    if (budget == 0) {
      title = "No Budget";
      message = "Set a monthly budget to start tracking your spending.";
      icon = Icons.account_balance_wallet_outlined;
      color = Colors.grey;
    } else {
      final percent = expense / budget;

      if (percent <= 0.30) {
        title = "Excellent!";
        message =
        "You're spending wisely this month. Keep up the good work!";
        icon = Icons.emoji_emotions_rounded;
        color = const Color(0xff7ED6A7);
      } else if (percent <= 0.60) {
        title = "Looking Good";
        message =
        "You've used ${(percent * 100).toStringAsFixed(0)}% of your monthly budget.";
        icon = Icons.thumb_up_alt_rounded;
        color = const Color(0xff6C63FF);
      } else if (percent <= 0.80) {
        title = "Be Careful";
        message =
        "You've already spent ${(percent * 100).toStringAsFixed(0)}% of your budget.";
        icon = Icons.warning_amber_rounded;
        color = const Color(0xffFFD166);
      } else if (percent <= 1.0) {
        title = "Almost There";
        message =
        "Only a small amount of your monthly budget is remaining.";
        icon = Icons.error_outline;
        color = const Color(0xffFF8A65);
      } else {
        title = "Budget Exceeded";
        message =
        "You exceeded your budget by ৳${(expense - budget).toStringAsFixed(0)}.";
        icon = Icons.cancel_rounded;
        color = const Color(0xffFF6B6B);
      }
    }

    return Container(
      width: double.infinity,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: color.withOpacity(.15),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  message,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.5,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}