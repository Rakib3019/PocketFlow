import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyActivityCard extends StatelessWidget {
  final List<double> weeklyExpense;

  const WeeklyActivityCard({
    super.key,
    required this.weeklyExpense,
  });

  @override
  Widget build(BuildContext context) {
    final average =
        weeklyExpense.reduce((a, b) => a + b) / weeklyExpense.length;

    final maxValue = weeklyExpense.isEmpty
        ? 100.0
        : weeklyExpense.reduce((a, b) => a > b ? a : b);
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
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Weekly Activity",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "Last 7 days spending",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  const Text(
                    "Average",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    "৳${average.toStringAsFixed(0)}",
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

          const SizedBox(height: 25),

          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(

                minX: 0,
                maxX: 6,

                minY: 0,
                maxY: maxValue == 0 ? 100 : maxValue * 1.2,

                borderData: FlBorderData(show: false),

                gridData: FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: maxValue <= 0 ? 25 : maxValue / 4,
                ),

                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => Colors.white,
                    tooltipPadding: const EdgeInsets.all(10),
                    getTooltipItems: (spots) {
                      return spots.map((spot) {
                        return LineTooltipItem(
                          "৳${spot.y.toStringAsFixed(0)}",
                          const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),

                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 45,
                      interval: maxValue <= 0 ? 25 : maxValue / 4,
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
                      reservedSize: 28,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const days = [
                          "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun",
                        ];

                        if (value < 0 || value > 6) {
                          return const SizedBox();
                        }

                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            days[value.toInt()],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                lineBarsData: [

                  LineChartBarData(
                    isCurved: true,
                    color: const Color(0xff6C63FF),
                    barWidth: 4,

                    isStrokeCapRound: true,

                    spots: List.generate(
                      weeklyExpense.length,
                          (index) => FlSpot(
                        index.toDouble(),
                        weeklyExpense[index],
                      ),
                    ),

                    dotData: const FlDotData(
                      show: false,
                    ),

                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xff6C63FF).withOpacity(.35),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}