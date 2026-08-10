import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyBudgetCard extends StatelessWidget {
  final List<double> monthlyBudget;
  final List<double> monthlyExpense;


  const MonthlyBudgetCard({
    super.key,
    required this.monthlyBudget,
    required this.monthlyExpense,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    const monthNames = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];

    final months = List.generate(
      6,
          (index) {
        final date = DateTime(
          now.year,
          now.month - 5 + index,
        );

        return monthNames[date.month - 1];
      },
    );

    final maxValue = [
      ...monthlyBudget,
      ...monthlyExpense,
    ].reduce(
          (a, b) => a > b ? a : b,
    );

    final averageUsage = () {
      double totalBudget = 0;
      double totalExpense = 0;

      for (int i = 0; i < monthlyBudget.length; i++) {
        totalBudget += monthlyBudget[i];
        totalExpense += monthlyExpense[i];
      }

      if (totalBudget == 0) return 0.0;

      return (totalExpense / totalBudget) * 100;
    }();

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

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Monthly Budget",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Budget vs Used (Last 6 Months)",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Average use",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),

                  Text(
                    "${averageUsage.toStringAsFixed(0)}%",
                    style: const TextStyle(
                      color: Color(0xff6C63FF),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _Legend(
                color: Color(0xff7ED6A7),
                title: "Budget",
              ),

              SizedBox(width: 18),

              _Legend(
                color: Color(0xffFF6B6B),
                title: "Used",
              ),
            ],
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 230,
            child: BarChart(
              BarChartData(
                maxY: maxValue == 0 ? 100 : maxValue * 1.2,

                alignment: BarChartAlignment.spaceAround,

                borderData: FlBorderData(
                  show: false,
                ),

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval:
                  maxValue == 0 ? 25 : maxValue / 4,
                ),

                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipPadding: const EdgeInsets.all(10),
                    tooltipMargin: 10,
                    getTooltipColor: (_) => Colors.white,

                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String title;

                      switch (rodIndex) {
                        case 0:
                          title = "Budget";
                          break;
                        case 1:
                          title = "Used";
                          break;
                        default:
                          title = "";
                      }

                      return BarTooltipItem(
                        "$title\n৳${rod.toY.toStringAsFixed(0)}",
                        const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      );
                    },
                  ),
                ),

                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(),

                  rightTitles: const AxisTitles(),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      interval: maxValue == 0 ? 25 : maxValue / 4,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          "৳${value.toInt()}",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= months.length) {
                          return const SizedBox();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            months[value.toInt()],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                barGroups: List.generate(
                  6,
                      (index) => BarChartGroupData(
                    x: index,
                    barsSpace: 4,
                    barRods: [
                      /// Budget
                      BarChartRodData(
                        toY: monthlyBudget[index],
                        width: 8,
                        color: const Color(0xff7ED6A7),
                        borderRadius:
                        BorderRadius.circular(6),
                      ),

                      /// Used
                      BarChartRodData(
                        toY: monthlyExpense[index],
                        width: 8,
                        color: const Color(0xffFF6B6B),
                        borderRadius:
                        BorderRadius.circular(6),
                      ),
                    ],
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

class _Legend extends StatelessWidget {
  final Color color;
  final String title;

  const _Legend({
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 6),

        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}