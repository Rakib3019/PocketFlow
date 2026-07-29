import 'package:flutter/material.dart';

import '../models/budget_model.dart';
import '../repositories/budget_repository.dart';

class BudgetViewModel extends ChangeNotifier {
  final BudgetRepository _repository = BudgetRepository();

  BudgetModel? _currentBudget;

  BudgetModel? get currentBudget => _currentBudget;

  BudgetViewModel() {
    loadCurrentBudget();
  }

  /// Load current month's budget
  Future<void> loadCurrentBudget() async {
    _currentBudget = await _repository.getCurrentBudget();

    notifyListeners();
  }

  /// Save or Update Budget
  Future<void> saveBudget(double amount) async {
    final now = DateTime.now();

    if (_currentBudget == null) {
      final budget = BudgetModel(
        amount: amount,
        month: now.month,
        year: now.year,
      );

      await _repository.insertBudget(budget);
    } else {
      final updatedBudget = BudgetModel(
        id: _currentBudget!.id,
        amount: amount,
        month: now.month,
        year: now.year,
      );

      await _repository.updateBudget(updatedBudget);
    }

    await loadCurrentBudget();
  }

  /// Delete Budget
  Future<void> deleteBudget() async {
    if (_currentBudget == null) return;

    await _repository.deleteBudget(_currentBudget!.id!);

    _currentBudget = null;

    notifyListeners();
  }


  /// Getters


  double get budgetAmount =>
      _currentBudget?.amount ?? 0;

  bool get hasBudget =>
      _currentBudget != null;

  /// Remaining Budget
  double remainingBudget(double expense) {
    return budgetAmount - expense;
  }

  /// Used Percentage
  double usedPercentage(double expense) {
    if (budgetAmount == 0) return 0;

    return (expense / budgetAmount).clamp(0.0, 1.0);
  }

  /// Remaining Percentage
  double remainingPercentage(double expense) {
    return 1 - usedPercentage(expense);
  }

  /// Budget Exceeded
  bool isBudgetExceeded(double expense) {
    return expense > budgetAmount;
  }

  /// Exceeded Amount
  double exceededAmount(double expense) {
    if (!isBudgetExceeded(expense)) {
      return 0;
    }

    return expense - budgetAmount;
  }
}