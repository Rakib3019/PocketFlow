import 'package:flutter/material.dart';

class LoanOverviewCard extends StatelessWidget {
  final double borrowed;
  final double lent;
  final int active;
  final int paid;

  const LoanOverviewCard({
    super.key,
    required this.borrowed,
    required this.lent,
    required this.active,
    required this.paid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff6C63FF),
            Color(0xff8B84FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff6C63FF).withOpacity(.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [

          const Text(
            "Loan Overview",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [

              Expanded(
                child: _info(
                  "Borrowed",
                  "৳${borrowed.toStringAsFixed(0)}",
                  Icons.call_received,
                ),
              ),

              Container(
                width: 1,
                height: 55,
                color: Colors.white24,
              ),

              Expanded(
                child: _info(
                  "Lent",
                  "৳${lent.toStringAsFixed(0)}",
                  Icons.call_made,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                _smallStat(
                  "Active",
                  active.toString(),
                  Colors.orangeAccent,
                ),

                Container(
                  width: 1,
                  height: 32,
                  color: Colors.white24,
                ),

                _smallStat(
                  "Paid",
                  paid.toString(),
                  Colors.greenAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _info(
      String title,
      String value,
      IconData icon,
      ) {
    return Column(
      children: [

        Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),

        const SizedBox(height: 10),

        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _smallStat(
      String title,
      String value,
      Color color,
      ) {
    return Column(
      children: [

        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}