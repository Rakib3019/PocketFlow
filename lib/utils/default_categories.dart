import 'package:flutter/material.dart';
import '../models/category_model.dart';

class DefaultCategories {
  static List<CategoryModel> categories = [

    /// Money Added Categories
    /// Salary
    CategoryModel(
      id: "salary",
      name: "Salary",
      icon: Icons.work_rounded,
      color: Colors.green,
      isExpense: false,
    ),
///family
    CategoryModel(
      id: "family",
      name: "Parents / Family",
      icon: Icons.family_restroom,
      color: Colors.blue,
      isExpense: false,
    ),
///scholarship
    CategoryModel(
      id: "scholarship",
      name: "Scholarship",
      icon: Icons.school,
      color: Colors.indigo,
      isExpense: false,
    ),
///freelance
    CategoryModel(
      id: "freelance",
      name: "Freelance",
      icon: Icons.laptop_mac,
      color: Colors.teal,
      isExpense: false,
    ),
///bonus
    CategoryModel(
      id: "bonus",
      name: "Bonus",
      icon: Icons.card_giftcard,
      color: Colors.orange,
      isExpense: false,
    ),
///gift
    CategoryModel(
      id: "gift",
      name: "Gift",
      icon: Icons.redeem,
      color: Colors.pink,
      isExpense: false,
    ),
///refund
    CategoryModel(
      id: "refund",
      name: "Refund",
      icon: Icons.reply,
      color: Colors.cyan,
      isExpense: false,
    ),
///others
    CategoryModel(
      id: "income_other",
      name: "Others",
      icon: Icons.more_horiz,
      color: Colors.grey,
      isExpense: false,
    ),

    /// Expense Categories
    CategoryModel(
      id: "food",
      name: "Food",
      icon: Icons.restaurant,
      color: Colors.deepOrange,
      isExpense: true,
    ),

    CategoryModel(
      id: "transport",
      name: "Transport",
      icon: Icons.directions_bus,
      color: Colors.blue,
      isExpense: true,
    ),

    CategoryModel(
      id: "shopping",
      name: "Shopping",
      icon: Icons.shopping_bag,
      color: Colors.purple,
      isExpense: true,
    ),

    CategoryModel(
      id: "medical",
      name: "Medical",
      icon: Icons.local_hospital,
      color: Colors.red,
      isExpense: true,
    ),

    CategoryModel(
      id: "bills",
      name: "Bills",
      icon: Icons.receipt_long,
      color: Colors.amber,
      isExpense: true,
    ),

    CategoryModel(
      id: "rent",
      name: "Rent",
      icon: Icons.home,
      color: Colors.brown,
      isExpense: true,
    ),

    CategoryModel(
      id: "education",
      name: "Education",
      icon: Icons.menu_book,
      color: Colors.indigo,
      isExpense: true,
    ),

    CategoryModel(
      id: "entertainment",
      name: "Entertainment",
      icon: Icons.movie,
      color: Colors.pink,
      isExpense: true,
    ),

    CategoryModel(
      id: "expense_other",
      name: "Others",
      icon: Icons.more_horiz,
      color: Colors.grey,
      isExpense: true,
    ),
  ];

///For showing category name
  static String getCategoryName(String id) {
    final category = categories.firstWhere(
          (category) => category.id == id,
      orElse: () => CategoryModel(
        id: id,
        name: id,
        icon: Icons.category,
        color: Colors.grey,
        isExpense: true,
      ),
    );

    return category.name;
  }
}