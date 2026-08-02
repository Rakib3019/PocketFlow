import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../models/loan_model.dart';
import '../../../utils/dialog_helper.dart';
import '../../../viewmodels/loan/add_loan_viewmodel.dart';
import '../../../viewmodels/loan/loan_viewmodel.dart';
import '../../../viewmodels/transaction/transaction_viewmodel.dart';

class SaveLoanButton extends StatelessWidget {
  const SaveLoanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: () async {
          final addVM = context.read<AddLoanViewModel>();
          final loanVM = context.read<LoanViewModel>();

// Clear previous message
          addVM.clearMessage();

// Validate Person Name
          if (addVM.person.isEmpty) {
            await showMessageDialog(
              context,
              title: "Invalid",
              message: "Please enter person's name.",
              color: Colors.orange,
              icon: Icons.warning_amber_rounded,
            );
            return;
          }

// Validate Amount
          if (addVM.amount <= 0) {
            await showMessageDialog(
              context,
              title: "Invalid",
              message: "Please enter a valid amount.",
              color: Colors.orange,
              icon: Icons.warning_amber_rounded,
            );
            return;
          }

// Create Loan
          final loan = LoanModel(
            id: const Uuid().v4(),
            person: addVM.person,
            amount: addVM.amount,
            isBorrowed: addVM.isBorrowed,
            date: addVM.date,
            dueDate: addVM.dueDate,
            note: addVM.note,
            status: "Active",
            linkedTransactionId: null,
          );

// Save Loan
          await loanVM.addLoan(loan);
//Refresh Transaction
          await context.read<TransactionViewModel>().loadTransactions();

          if (!context.mounted) return;

// Success
          await showMessageDialog(
            context,
            title: "Success",
            message: "Loan added successfully!",
            color: Colors.green,
            icon: Icons.check_circle,
          );

// Reset Form
          addVM.reset();

          if (!context.mounted) return;

// Close Bottom Sheet
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
        label: const Text(
          "Save Loan",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
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