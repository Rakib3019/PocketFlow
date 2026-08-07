import 'package:flutter/material.dart';
import 'package:pocket_mate/view/widgets/loan/loan_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/loan/loan_viewmodel.dart';
import '../../widgets/loan/laon_overview_card.dart';
import '../../widgets/loan/loan_filter_chips.dart';
import 'loan_detail_screen.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loanVM = context.watch<LoanViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            top: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom + 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Loan AppBar
              const LoanAppBar(),

              const SizedBox(height: 16),

              /// Loan Overview
              LoanOverviewCard(
                borrowed: loanVM.activeBorrowed,
                lent: loanVM.activeLent,
                active: loanVM.activeLoans,
                paid: loanVM.paidLoans,
              ),

              const SizedBox(height: 16),

              /// Filter Chips
              const LoanFilterChips(),

              const SizedBox(height: 20),

              /// Search
              TextField(
                decoration: InputDecoration(
                  hintText: "Search loans...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: loanVM.searchLoans,
              ),

              const SizedBox(height: 20),

              /// Loan List
              loanVM.filteredLoans.isEmpty
                  ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(
                  child: Text(
                    "No Loans Found",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(),
                itemCount: loanVM.filteredLoans.length,
                itemBuilder: (_, index) {
                  final loan = loanVM.filteredLoans[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoanDetailScreen(
                            loan: loan,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin:
                      const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(18),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: loan.isBorrowed
                              ? const Color(0xff7ED6A7)
                              .withOpacity(.2)
                              : const Color(0xffFF6B6B)
                              .withOpacity(.2),
                          child: Icon(
                            loan.isBorrowed
                                ? Icons.call_received
                                : Icons.call_made,
                            color: loan.isBorrowed
                                ? const Color(0xff7ED6A7)
                                : const Color(0xffFF6B6B),
                          ),
                        ),
                        title: Text(
                          loan.person,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              loan.isBorrowed
                                  ? "Borrowed"
                                  : "Lent",
                            ),
                            Text(
                              loan.status,
                              style: TextStyle(
                                color:
                                loan.status == "Paid"
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        trailing: Text(
                          "৳${loan.amount.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}