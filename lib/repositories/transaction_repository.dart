import 'package:sqflite/sqflite.dart';

import '../models/transaction_model.dart';
import '../services/database_service.dart';

class TransactionRepository {
  final DatabaseService _databaseService = DatabaseService.instance;

  /// Insert Transaction
  Future<void> insertTransaction(TransactionModel transaction) async {
    final Database db = await _databaseService.database;

    await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get All Transactions
  Future<List<TransactionModel>> getTransactions() async {
    final Database db = await _databaseService.database;

    final List<Map<String, dynamic>> maps =
    await db.query(
      'transactions',
      orderBy: 'date DESC',
    );

    return maps
        .map((map) => TransactionModel.fromMap(map))
        .toList();
  }

  /// Update Transaction
  Future<void> updateTransaction(
      TransactionModel transaction,
      ) async {
    final Database db = await _databaseService.database;

    await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  /// Delete Transaction
  Future<void> deleteTransaction(String id) async {
    final Database db = await _databaseService.database;

    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  ///insert transaction for loan
  Future<void> insertTransactionWithModel(
      TransactionModel transaction,
      ) async {
    final Database db = await _databaseService.database;

    await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

///delete loan
  Future<void> deleteTransactionByLoanId(String loanId) async {
    final Database db = await _databaseService.database;

    await db.delete(
      'transactions',
      where: 'linkedLoanId = ?',
      whereArgs: [loanId],
    );
  }

}