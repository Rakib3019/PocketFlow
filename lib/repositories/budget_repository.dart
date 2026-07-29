import 'package:sqflite/sqflite.dart';

import '../models/budget_model.dart';
import '../services/database_service.dart';

class BudgetRepository {
  final DatabaseService _databaseService = DatabaseService.instance;

  /// Insert new monthly budget
  Future<void> insertBudget(BudgetModel budget) async {
    final db = await _databaseService.database;

    await db.insert(
      'budgets',
      budget.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Update existing budget
  Future<void> updateBudget(BudgetModel budget) async {
    final db = await _databaseService.database;

    await db.update(
      'budgets',
      budget.toMap(),
      where: 'id = ?',
      whereArgs: [budget.id],
    );
  }

  /// Delete budget
  Future<void> deleteBudget(int id) async {
    final db = await _databaseService.database;

    await db.delete(
      'budgets',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Get current month's budget
  Future<BudgetModel?> getCurrentBudget() async {
    final db = await _databaseService.database;

    final now = DateTime.now();

    final result = await db.query(
      'budgets',
      where: 'month = ? AND year = ?',
      whereArgs: [
        now.month,
        now.year,
      ],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return BudgetModel.fromMap(result.first);
  }

  /// Get budget by month & year
  Future<BudgetModel?> getBudgetByMonth(
      int month,
      int year,
      ) async {
    final db = await _databaseService.database;

    final result = await db.query(
      'budgets',
      where: 'month = ? AND year = ?',
      whereArgs: [month, year],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return BudgetModel.fromMap(result.first);
  }

  /// Get all budgets
  Future<List<BudgetModel>> getAllBudgets() async {
    final db = await _databaseService.database;

    final result = await db.query(
      'budgets',
      orderBy: 'year DESC, month DESC',
    );

    return result
        .map((e) => BudgetModel.fromMap(e))
        .toList();
  }
}