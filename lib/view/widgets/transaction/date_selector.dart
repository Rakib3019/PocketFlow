import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/transaction/add_transaction_viewmodel.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddTransactionViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: vm.selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              vm.changeDate(pickedDate);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_month_outlined),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    DateFormat('dd MMM yyyy').format(vm.selectedDate),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ),
      ],
    );
  }
}