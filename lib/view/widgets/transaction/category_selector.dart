import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/category_model.dart';
import '../../../viewmodels/transaction/add_transaction_viewmodel.dart';
import '../../../viewmodels/category_viewmodel.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final addVM = context.watch<AddTransactionViewModel>();
    final categoryVM = context.watch<CategoryViewModel>();

    final List<CategoryModel> categories = addVM.isIncome
        ? categoryVM.moneyAddedCategories
        : categoryVM.expenseCategories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Category",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: categories.map((category) {
              final selected = addVM.selectedCategory == category.id;

              return InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  addVM.selectCategory(category.id);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? category.color.withOpacity(.15)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: selected
                          ? category.color.withOpacity(.5)
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        category.icon,
                        size: 18,
                        color: category.color,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                          selected ? FontWeight.w600 : FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}