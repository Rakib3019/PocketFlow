import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/loan/add_loan_viewmodel.dart';

class LoanAmountField extends StatelessWidget {
  const LoanAmountField({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddLoanViewModel>();

    return TextField(
      controller: vm.amountController,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d*\.?\d{0,2}'),
        ),
      ],
      decoration: InputDecoration(
        labelText: "Amount",
        hintText: "Enter loan amount",
        prefixIcon: const Icon(
          Icons.account_balance_wallet_outlined,
        ),
        prefixText: "৳ ",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xff6C63FF),
            width: 2,
          ),
        ),
      ),
    );
  }
}