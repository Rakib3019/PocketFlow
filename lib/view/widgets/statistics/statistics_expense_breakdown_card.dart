import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpenseBreakdownCard extends StatelessWidget {
  final List<MapEntry<String, double>> categories;
  final double others;
  final double totalExpense;

///number format
  String formatAmount(double value) {
    String format(double number) {
      return number % 1 == 0
          ? number.toStringAsFixed(0)
          : number.toStringAsFixed(1);
    }

    if (value >= 1000000000) {
      return "${format(value / 1000000000)}B";
    }

    if (value >= 1000000) {
      return "${format(value / 1000000)}M";
    }

    if (value >= 1000) {
      return "${format(value / 1000)}K";
    }

    return value.toStringAsFixed(0);
  }

  const ExpenseBreakdownCard({
    super.key,
    required this.categories,
    required this.others,
    required this.totalExpense,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xff6C63FF),
      const Color(0xff7ED6A7),
      const Color(0xffFFD166),
      const Color(0xffFF6B6B),
    ];

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Expense Breakdown",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Top spending categories",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 240,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    centerSpaceRadius: 70,
                    sectionsSpace: 5,
                    borderData: FlBorderData(show: false),
                    sections: [
                      for (int i = 0; i < categories.length; i++)
                        PieChartSectionData(
                          value: categories[i].value,
                          color: colors[i],
                          radius: 24,
                          showTitle: false,
                        ),

                      if (others > 0)
                        PieChartSectionData(
                          value: others,
                          color: Colors.grey.shade400,
                          radius: 24,
                          showTitle: false,
                        ),
                    ],
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "৳${formatAmount(totalExpense)}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: [
              for (int i = 0; i < categories.length; i++)
                _LegendItem(
                  color: colors[i],
                  title: categories[i].key,
                  amount: categories[i].value,
                ),

              if (others > 0)
                _LegendItem(
                  color: Colors.grey,
                  title: "Others",
                  amount: others,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String title;
  final double amount;

  const _LegendItem({
    required this.color,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 12,
            width: 12,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  "৳${amount.toStringAsFixed(0)}",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
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