import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/transaction/add_transaction_viewmodel.dart';

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddTransactionViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Payment Method",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => _showPaymentMethods(context),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.account_balance_wallet_outlined,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    vm.paymentMethod,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showPaymentMethods(BuildContext context) {
    final vm = context.read<AddTransactionViewModel>();

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (_) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: vm.paymentMethods.length,
          itemBuilder: (context, index) {
            final method = vm.paymentMethods[index];

            return ListTile(
              title: Text(method),

              trailing: vm.paymentMethod == method
                  ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
                  : null,

              onTap: () {
                vm.changePaymentMethod(method);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}