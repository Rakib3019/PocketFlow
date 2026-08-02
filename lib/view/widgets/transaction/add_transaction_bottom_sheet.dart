import 'package:flutter/material.dart';

import 'package:pocket_mate/view/widgets/transaction/amount_field.dart';
import 'package:pocket_mate/view/widgets/transaction/date_selector.dart';
import 'package:pocket_mate/view/widgets/transaction/note_field.dart';
import 'package:pocket_mate/view/widgets/transaction/payment_method_selector.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/transaction/add_transaction_viewmodel.dart';
import 'category_selector.dart';
import 'income_expense_selector.dart';
import 'save_transaction_button.dart';

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height:20),
                Text(
                  "Add Transaction",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
///expense selector
                SizedBox(height: 12),
                IncomeExpenseSelector(),
///errore message
                SizedBox(height: 2),
                Consumer<AddTransactionViewModel>(
                  builder: (context, vm, child) {
                    if (vm.message == null) {
                      return const SizedBox.shrink();
                    }

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 16, bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: vm.messageColor.withOpacity(.10),
                        border: Border.all(color: vm.messageColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            vm.messageIcon,
                            color: vm.messageColor,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              vm.message!,
                              style: TextStyle(
                                color: vm.messageColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
///amount
                SizedBox(height:8),
                AmountField(),
///category
                SizedBox(height: 8),
                CategorySelector(),
///payment method
                SizedBox(height: 8),
                PaymentMethodSelector(),
///date
                SizedBox(height: 8),
                DateSelector(),
///note
                SizedBox(height: 8),
                NoteField(),
///save button
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