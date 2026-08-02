import 'package:sqflite/sqflite.dart';

import '../models/loan_model.dart';
import '../services/database_service.dart';

class LoanRepository {
  final DatabaseService _databaseService = DatabaseService.instance;

  /// Insert Loan
  Future<void> insertLoan(LoanModel loan) async {
    final db = await _databaseService.database;

    await db.insert(
      'loans',
      loan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Update Loan
  Future<void> updateLoan(LoanModel loan) async {
    final db = await _databaseService.database;

    await db.update(
      'loans',
      loan.toMap(),
      where: 'id = ?',
      whereArgs: [loan.id],
    );
  }

  /// Delete Loan
  Future<void> deleteLoan(String id) async {
    final db = await _databaseService.database;

    await db.delete(
      'loans',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Get All Loans
  Future<List<LoanModel>> getLoans() async {
    final db = await _databaseService.database;

    final result = await db.query(
      'loans',
      orderBy: 'date DESC',
    );

    return result.map((e) => LoanModel.fromMap(e)).toList();
  }

  /// Get Loan By ID
  Future<LoanModel?> getLoanById(String id) async {
    final db = await _databaseService.database;

    final result = await db.query(
      'loans',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return LoanModel.fromMap(result.first);
  }
}