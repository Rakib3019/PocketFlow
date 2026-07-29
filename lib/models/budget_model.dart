class BudgetModel {
  final int? id;
  final double amount;
  final int month;
  final int year;

  BudgetModel({
    this.id,
    required this.amount,
    required this.month,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'month': month,
      'year': year,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'],
      amount: (map['amount'] as num).toDouble(),
      month: map['month'],
      year: map['year'],
    );
  }
}