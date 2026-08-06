import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../models/transaction_model.dart';
import '../../../utils/dialog_helper.dart';
import '../../../viewmodels/transaction/add_transaction_viewmodel.dart';
import '../../../viewmodels/transaction/transaction_viewmodel.dart';

class SaveTransactionButton extends StatelessWidget {
  const SaveTransactionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: () async {
          final addVM = context.read<AddTransactionViewModel>();
          final transactionVM = context.read<TransactionViewModel>();

          // Clear previous message
          addVM.clearMessage();

          // Validation
          if (addVM.amount <= 0) {
            await showMessageDialog(
              context,
              title: "Invalid",
              message: "Please enter an amount.",
              color: Colors.orange,
              icon: Icons.warning_amber_rounded,
            );
            return;
          }

          if (addVM.selectedCategory == null) {
            await showMessageDialog(
              context,
              title: "Invalid",
              message: "Please select a category.",
              color: Colors.orange,
              icon: Icons.warning_amber_rounded,
            );
            return;
          }


          /// NEW VALIDATION
          if (!addVM.isIncome &&
              addVM.amount > transactionVM.currentBalance) {
            await showMessageDialog(
              context,
              title: "Insufficient Balance",
              message:
              "You don't have enough balance to complete this expense.",
              color: Colors.red,
              icon: Icons.error_outline,
            );
            return;
          }
          /// ==============================

          final transaction = TransactionModel(
            id: const Uuid().v4(),
            amount: addVM.amount,
            isIncome: addVM.isIncome,
            categoryId: addVM.selectedCategory!,
            paymentMethod: addVM.paymentMethod,
            note: addVM.note,
            date: addVM.selectedDate,
            createdAt: DateTime.now(),
          );

          // Save transaction
          await transactionVM.addTransaction(transaction);

          // Success message
          await showMessageDialog(
            context,
            title: "Success",
            message: "Transaction saved successfully!",
            color: Colors.green,
            icon: Icons.check_circle,
          );

          await Future.delayed(const Duration(milliseconds: 100));

          if (!context.mounted) return;

          // Reset form
          addVM.reset();

          // Close Bottom Sheet
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
        label: const Text(
          "Save Transaction",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 58),
          backgroundColor: const Color(0xff6C63FF),
          foregroundColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}