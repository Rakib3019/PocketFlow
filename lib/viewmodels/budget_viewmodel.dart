import 'package:flutter/material.dart';

import '../models/budget_model.dart';
import '../repositories/budget_repository.dart';

class BudgetViewModel extends ChangeNotifier {
  /// Repository

  final BudgetRepository _repository = BudgetRepository();

  /// Variables

  BudgetModel? _currentBudget;

  List<BudgetModel> _budgets = [];


  /// Constructor

  BudgetViewModel() {
    loadCurrentBudget();
    loadBudgets();
  }


  /// Getters

  BudgetModel? get currentBudget => _currentBudget;

  List<BudgetModel> get budgets => _budgets;

  double get budgetAmount => _currentBudget?.amount ?? 0;

  bool get hasBudget => _currentBudget != null;


  /// Load Data

  /// Load current month's budget
  Future<void> loadCurrentBudget() async {
    _currentBudget = await _repository.getCurrentBudget();
    notifyListeners();
  }

  /// Load all budgets
  Future<void> loadBudgets() async {
    _budgets = await _repository.getAllBudgets();
    notifyListeners();
  }


  /// Save Budget


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
    await loadBudgets();
  }


  /// Delete Budget

  Future<void> deleteBudget() async {
    if (_currentBudget == null) return;

    await _repository.deleteBudget(_currentBudget!.id!);

    _currentBudget = null;

    await loadBudgets();

    notifyListeners();
  }


  /// Budget Calculations

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


  /// Statistics

  /// Last 6 Months Budget Data
  List<double> get monthlyBudgetData {
    final now = DateTime.now();

    List<double> data = [];

    for (int i = 5; i >= 0; i--) {
      final month = DateTime(
        now.year,
        now.month - i,
      );

      final budget = _budgets.where(
            (b) =>
        b.month == month.month &&
            b.year == month.year,
      );

      if (budget.isEmpty) {
        data.add(0);
      } else {
        data.add(budget.first.amount);
      }
    }

    return data;
  }
}