import 'package:flutter/material.dart';
import '../../../models/transaction_model.dart';
import '../../../viewmodels/transaction/transaction_viewmodel.dart';
import '../../widgets/history/delete_transaction_dialog.dart';
import 'package:provider/provider.dart';


class TransactionDetailsScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailsScreen({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMoneyAdded = transaction.isIncome;

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Transaction Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

/// Top Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
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

                  CircleAvatar(
                    radius: 35,
                    backgroundColor:
                    (isMoneyAdded
                        ? const Color(0xff7ED6A7)
                        : const Color(0xffFF6B6B))
                        .withOpacity(.15),
                    child: Icon(
                      isMoneyAdded
                          ? Icons.arrow_downward_rounded
                          : Icons.arrow_upward_rounded,
                      color: isMoneyAdded
                          ? const Color(0xff7ED6A7)
                          : const Color(0xffFF6B6B),
                      size: 34,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    transaction.categoryId,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    isMoneyAdded ? "Money Added" : "Expense",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "${isMoneyAdded ? "+" : "-"}৳${transaction.amount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: isMoneyAdded
                          ? const Color(0xff7ED6A7)
                          : const Color(0xffFF6B6B),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _buildTile(
              "Category",
              transaction.categoryId,
              Icons.category_outlined,
            ),

            _buildTile(
              "Payment Method",
              transaction.paymentMethod,
              Icons.account_balance_wallet_outlined,
            ),

            _buildTile(
              "Date",
              "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
              Icons.calendar_today_outlined,
            ),

            _buildTile(
              "Note",
              transaction.note.isEmpty
                  ? "No note"
                  : transaction.note,
              Icons.notes_rounded,
            ),

            _buildTile(
              "Created At",
              "${transaction.createdAt.day}/${transaction.createdAt.month}/${transaction.createdAt.year}",
              Icons.schedule,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Edit later
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit Transaction"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6C63FF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => DeleteTransactionDialog(
                      onDelete: () async {
                        await context
                            .read<TransactionViewModel>()
                            .deleteTransaction(transaction.id);

                        Navigator.pop(context); // Close dialog
                        Navigator.pop(context); // Close details screen
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text("Delete Transaction"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(
      String title,
      String value,
      IconData icon,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [

            Icon(
              icon,
              color: const Color(0xff6C63FF),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}