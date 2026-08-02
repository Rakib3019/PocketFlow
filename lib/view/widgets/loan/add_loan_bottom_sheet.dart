import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/loan/add_loan_viewmodel.dart';
import 'laon_note_field.dart';
import 'loan_due_date_selector.dart';
import 'loan_type_selector.dart';
import 'person_name_field.dart';
import 'loan_amount_field.dart';
import 'loan_date_selector.dart';
import 'save_loan_button.dart';

class AddLoanBottomSheet extends StatelessWidget {
  const AddLoanBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddLoanViewModel(),
      child: SafeArea(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
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
                children: const [

                  SizedBox(height: 10),

                  Text(
                    "Add Loan",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20),

                  LoanTypeSelector(),
                  SizedBox(height: 16),

                  PersonNameField(),
                  SizedBox(height: 16),

                  LoanAmountField(),
                  SizedBox(height: 16),

                  LoanDateSelector(),
                  SizedBox(height: 16),

                  DueDateSelector(),
                  SizedBox(height: 16),

                  LoanNoteField(),
                  SizedBox(height: 24),

                  SaveLoanButton(),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}