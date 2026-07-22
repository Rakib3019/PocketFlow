class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final bool isIncome;

  final String categoryId;
  final DateTime date;

  final String paymentMethod;

  final String note;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.isIncome,
    required this.categoryId,
    required this.date,
    required this.paymentMethod,
    required this.note,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "amount": amount,
    "isIncome": isIncome,
    "categoryId": categoryId,
    "date": date.toIso8601String(),
    "paymentMethod": paymentMethod,
    "note": note,
  };

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json["id"],
      title: json["title"],
      amount: (json["amount"] as num).toDouble(),
      isIncome: json["isIncome"],
      categoryId: json["categoryId"],
      date: DateTime.parse(json["date"]),
      paymentMethod: json["paymentMethod"],
      note: json["note"] ?? "",
    );
  }
}