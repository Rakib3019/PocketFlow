import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/loan/add_loan_viewmodel.dart';

class LoanNoteField extends StatelessWidget {
  const LoanNoteField({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddLoanViewModel>();

    return TextField(
      maxLines: 3,
      textCapitalization: TextCapitalization.sentences,
      onChanged: vm.changeNote,
      decoration: InputDecoration(
        labelText: "Note (Optional)",
        hintText: "Write a note...",
        alignLabelWithHint: true,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(bottom: 48),
          child: Icon(Icons.notes_outlined),
        ),
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