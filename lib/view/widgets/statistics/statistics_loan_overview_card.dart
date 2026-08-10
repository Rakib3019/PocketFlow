import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticsLoanOverviewCard extends StatelessWidget {
  final double borrowed;
  final double lent;
  final int active;
  final int paid;

  final List<double> monthlyBorrowed;
  final List<double> monthlyLent;

  const StatisticsLoanOverviewCard({
    super.key,
    required this.borrowed,
    required this.lent,
    required this.active,
    required this.paid,
    required this.monthlyBorrowed,
    required this.monthlyLent,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    const monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];

    final months = List.generate(6, (index) {
        final date = DateTime(
          now.year,
          now.month - 5 + index,
        );

        return monthNames[date.month - 1];
      },
    );

    final maxValue = [
      ...monthlyBorrowed,
      ...monthlyLent,
    ].reduce((a, b) => a > b ? a : b);

    final netLoan = lent - borrowed;
    final bool positive = netLoan >= 0;

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
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Loan Overview",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Borrowed vs Lent (Last 6 Months)",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [

              Expanded(
                child: _SummaryCard(
                  title: "Borrowed",
                  value: borrowed,
                  color: const Color(0xff6C63FF),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _SummaryCard(
                  title: "Lent",
                  value: lent,
                  color: const Color(0xffFF9F43),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [

              Expanded(
                child: _CountCard(
                  title: "Active",
                  value: active,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _CountCard(
                  title: "Paid",
                  value: paid,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: positive
                  ? const Color(0xffE8F7EF)
                  : const Color(0xffFFF1F1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [

                const Text(
                  "Net Position",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "${positive ? "+" : "-"}৳${netLoan.abs().toStringAsFixed(0)}",
                  style: TextStyle(
                    color: positive
                        ? const Color(0xff2ECC71)
                        : const Color(0xffFF6B6B),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  positive
                      ? "You will receive more money"
                      : "You owe more money",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: const [

              _Legend(
                color: Color(0xff7ED6A7),
                title: "Borrowed",
              ),

              SizedBox(width: 20),

              _Legend(
                color: Color(0xffFF6B6B),
                title: "Lent",
              ),
            ],
          ),

          const SizedBox(height: 22),

          SizedBox(
            height: 230,
            child: BarChart(
              BarChartData(
                maxY: maxValue == 0
                    ? 100
                    : maxValue * 1.2,

                alignment:
                BarChartAlignment.spaceAround,

                borderData:
                FlBorderData(show: false),

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxValue == 0 ? 25 : maxValue / 4,
                ),

                barTouchData: BarTouchData(
                  enabled: true,

                  touchTooltipData:
                  BarTouchTooltipData(
                    tooltipPadding:
                    const EdgeInsets.all(10),

                    tooltipMargin: 10,

                    getTooltipColor: (_) =>
                    Colors.white,

                    getTooltipItem:
                        (
                        group,
                        groupIndex,
                        rod,
                        rodIndex,
                        ) {

                      String title =
                      rodIndex == 0
                          ? "Borrowed"
                          : "Lent";

                      return BarTooltipItem(
                        "$title\n৳${rod.toY.toStringAsFixed(0)}",
                        const TextStyle(
                          color: Colors.black,
                          fontWeight:
                          FontWeight.bold,
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
                          padding:
                          const EdgeInsets.only(top: 8),
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

                      BarChartRodData(
                        toY: monthlyBorrowed[index],
                        width: 8,
                        color: const Color(0xff7ED6A7),
                        borderRadius:
                        BorderRadius.circular(6),
                      ),

                      BarChartRodData(
                        toY: monthlyLent[index],
                        width: 8,
                        color: Color(0xffFF6B6B),
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
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final double value;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.color,
  });

  String format(double value) {
    if (value >= 1000000000) {
      return "${(value / 1000000000).toStringAsFixed(1)}B";
    }

    if (value >= 1000000) {
      return "${(value / 1000000).toStringAsFixed(1)}M";
    }

    if (value >= 1000) {
      return "${(value / 1000).toStringAsFixed(1)}K";
    }

    return value.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "৳${format(value)}",
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountCard extends StatelessWidget {
  final String title;
  final int value;
  final Color color;

  const _CountCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value.toString(),
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}