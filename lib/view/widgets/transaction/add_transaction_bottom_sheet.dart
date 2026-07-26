import 'package:flutter/material.dart';
import 'package:pocket_mate/view/widgets/transaction/amount_field.dart';
import 'package:pocket_mate/view/widgets/transaction/date_selector.dart';
import 'package:pocket_mate/view/widgets/transaction/note_field.dart';
import 'package:pocket_mate/view/widgets/transaction/payment_method_selector.dart';
import 'package:pocket_mate/view/widgets/transaction/save_transaction_button.dart';

import 'category_selector.dart';
import 'income_expense_selector.dart';

class AddTransactionBottomSheet extends StatelessWidget {
  const AddTransactionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: SingleChildScrollView(
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                  "Add Transaction",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),
                IncomeExpenseSelector(),

                SizedBox(height: 12),
                AmountField(),

                SizedBox(height: 12),
                CategorySelector(),

                SizedBox(height: 12),
                PaymentMethodSelector(),

                SizedBox(height: 12),
                DateSelector(),

                SizedBox(height: 12),
                NoteField(),

                SizedBox(height: 22),
                SaveTransactionButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}