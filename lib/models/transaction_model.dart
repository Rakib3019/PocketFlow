class TransactionModel {
  final String id;

  final double amount;

  /// false = Expense
  /// true = Money Added
  final bool isIncome;

  /// Stores Category ID
  final String categoryId;

  final String paymentMethod;

  final String note;

  final DateTime date;

  final DateTime createdAt;

  /// Used for Loan Transactions
  final String? linkedLoanId;

  /// Should this transaction affect Monthly Budget?
  final bool affectsBudget;

  const TransactionModel({
    required this.id,
    required this.amount,
    required this.isIncome,
    required this.categoryId,
    required this.paymentMethod,
    required this.note,
    required this.date,
    required this.createdAt,
    this.linkedLoanId,
    this.affectsBudget = true,
  });

  TransactionModel copyWith({
    String? id,
    double? amount,
    bool? isIncome,
    String? categoryId,
    String? paymentMethod,
    String? note,
    DateTime? date,
    DateTime? createdAt,
    String? linkedLoanId,
    bool? affectsBudget,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      isIncome: isIncome ?? this.isIncome,
      categoryId: categoryId ?? this.categoryId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      note: note ?? this.note,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      linkedLoanId: linkedLoanId ?? this.linkedLoanId,
      affectsBudget: affectsBudget ?? this.affectsBudget,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'isIncome': isIncome ? 1 : 0,
      'categoryId': categoryId,
      'paymentMethod': paymentMethod,
      'note': note,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'linkedLoanId': linkedLoanId,
      'affectsBudget': affectsBudget ? 1 : 0,
    };
  }

  factory TransactionModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return TransactionModel(
      id: map['id'],
      amount: map['amount'].toDouble(),
      isIncome: map['isIncome'] == 1,
      categoryId: map['categoryId'],
      paymentMethod: map['paymentMethod'],
      note: map['note'],
      date: DateTime.parse(map['date']),
      createdAt: DateTime.parse(map['createdAt']),
      linkedLoanId: map['linkedLoanId'],
      affectsBudget:
      (map['affectsBudget'] ?? 1) == 1,
    );
  }
}