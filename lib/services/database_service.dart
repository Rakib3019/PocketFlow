import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'pocketflow.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(
      Database db,
      int version,
      ) async {
    // Transactions Table
    await db.execute('''
      CREATE TABLE transactions(
        id TEXT PRIMARY KEY,
        amount REAL,
        isIncome INTEGER,
        categoryId TEXT,
        paymentMethod TEXT,
        note TEXT,
        date TEXT,
        createdAt TEXT,
        linkedLoanId TEXT
      )
    ''');

    // Categories Table
    await db.execute('''
      CREATE TABLE categories(
        id TEXT PRIMARY KEY,
        name TEXT,
        icon INTEGER,
        color INTEGER,
        isExpense INTEGER,
        isDefault INTEGER
      )
    ''');

    // Loans Table
    await db.execute('''
      CREATE TABLE loans(
        id TEXT PRIMARY KEY,
        person TEXT,
        amount REAL,
        isBorrowed INTEGER,
        date TEXT,
        dueDate TEXT,
        note TEXT,
        status TEXT,
        linkedTransactionId TEXT
      )
    ''');
  }
}