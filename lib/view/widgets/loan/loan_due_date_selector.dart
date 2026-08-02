import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/loan/add_loan_viewmodel.dart';

class DueDateSelector extends StatelessWidget {
  const DueDateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddLoanViewModel>();

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: vm.dueDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          vm.changeDueDate(pickedDate);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
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
            const Icon(
              Icons.event_available_outlined,
              color: Color(0xff6C63FF),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    "Due Date (Optional)",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    vm.dueDate == null
                        ? "No Due Date"
                        : DateFormat(
                      "dd MMM yyyy",
                    ).format(vm.dueDate!),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: vm.dueDate == null
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            if (vm.dueDate != null)
              IconButton(
                onPressed: () {
                  vm.changeDueDate(null);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              )
            else
              const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}