import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String category;
  final String? note;
  final double amount;
  final DateTime date;
  final IconData icon;
  final Color iconColor;
  final bool isIncome;

  const TransactionTile({
    super.key,
    required this.title,
    required this.category,
    this.note,
    required this.amount,
    required this.date,
    required this.icon,
    required this.iconColor,
    required this.isIncome,
  });

  String formatDate(DateTime date) {
    final now = DateTime.now();

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return "Today";
    }

    final yesterday = now.subtract(const Duration(days: 1));

    if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return "Yesterday";
    }

    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          // Transaction information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                // Category + Date
                Text(
                  "$category • ${formatDate(date)}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),

                // Note
                if (note != null && note!.trim().isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    note!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Amount + arrow
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isIncome ? '+' : '-'}৳${amount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: isIncome
                      ? const Color(0xff7ED6A7)
                      : const Color(0xffFF6B6B),
                ),
              ),

              const SizedBox(height: 6),

              Icon(
                isIncome
                    ? Icons.arrow_circle_up_rounded
                    : Icons.arrow_circle_down_rounded,
                size: 18,
                color: isIncome
                    ? const Color(0xff7ED6A7)
                    : const Color(0xffFF6B6B),
              ),
            ],
          ),
        ],
      ),
    );
  }
}