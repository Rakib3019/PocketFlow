import 'package:flutter/material.dart';

import '../../../models/loan_model.dart';
import '../../../viewmodels/loan/loan_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/transaction/transaction_viewmodel.dart';

class LoanDetailScreen extends StatelessWidget {
  final LoanModel loan;

  const LoanDetailScreen({
    super.key,
    required this.loan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          "Loan Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            /// Person Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),

              child: Column(
                children: [

                  CircleAvatar(
                    radius: 34,
                    backgroundColor:
                    loan.isBorrowed
                        ? const Color(0xff7ED6A7).withOpacity(.2)
                        : const Color(0xffFF6B6B).withOpacity(.2),

                    child: Icon(
                      loan.isBorrowed
                          ? Icons.call_received
                          : Icons.call_made,
                      size: 34,
                      color: loan.isBorrowed
                          ? const Color(0xff7ED6A7)
                          : const Color(0xffFF6B6B),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    loan.person,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    loan.isBorrowed
                        ? "Borrowed"
                        : "Lent",
                  ),

                  const SizedBox(height: 14),

                  Text(
                    "৳${loan.amount.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Chip(
                    label: Text(
                      loan.status,
                    ),
                    backgroundColor:
                    loan.status == "Paid"
                        ? Colors.green.shade100
                        : Colors.orange.shade100,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _buildTile(
              Icons.calendar_today,
              "Loan Date",
              loan.date.toString().split(" ").first,
            ),

            _buildTile(
              Icons.event,
              "Due Date",
              loan.dueDate == null
                  ? "-"
                  : loan.dueDate
                  .toString()
                  .split(" ")
                  .first,
            ),

            _buildTile(
              Icons.notes,
              "Note",
              loan.note.isEmpty
                  ? "-"
                  : loan.note,
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {

                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit Loan"),
              ),
            ),

            const SizedBox(height: 12),
///paid button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final loanVM = context.read<LoanViewModel>();
                  final transactionVM = context.read<TransactionViewModel>();

                  // Only borrowed loans reduce your balance when paying
                  if (loan.isBorrowed &&
                      transactionVM.currentBalance < loan.amount) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Insufficient balance! Add more money before repaying this loan.",
                        ),
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );

                    return;
                  }

                  await loanVM.markAsPaid(loan);

                  // Refresh transactions immediately
                  await transactionVM.loadTransactions();

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Loan marked as paid successfully."),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.green,
                  foregroundColor:
                  Colors.white,
                ),
                icon: const Icon(Icons.check),
                label: const Text("Mark as Paid"),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.red,
                  foregroundColor:
                  Colors.white,
                ),
                icon: const Icon(Icons.delete),
                label: const Text("Delete Loan"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(
      IconData icon,
      String title,
      String value,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}