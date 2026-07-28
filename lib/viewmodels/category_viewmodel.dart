import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../utils/default_categories.dart';

class CategoryViewModel extends ChangeNotifier {
  CategoryViewModel() {
    loadCategories();
  }

  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;

  /// Expense Categories
  List<CategoryModel> get expenseCategories =>
      _categories.where((c) => c.isExpense).toList();

  /// Money Added Categories
  List<CategoryModel> get moneyAddedCategories =>
      _categories.where((c) => !c.isExpense).toList();

  /// Load Default Categories
  void loadCategories() {
    _categories = List.from(DefaultCategories.categories);
    notifyListeners();
  }

  /// Add Custom Category
  void addCategory(CategoryModel category) {
    _categories.add(category);
    notifyListeners();
  }

  /// Edit Category
  void editCategory(CategoryModel updatedCategory) {
    final index =
    _categories.indexWhere((c) => c.id == updatedCategory.id);

    if (index != -1) {
      _categories[index] = updatedCategory;
      notifyListeners();
    }
  }

  /// Delete Custom Category Only
  void deleteCategory(String id) {
    final index = _categories.indexWhere((c) => c.id == id);

    if (index == -1) return;

    if (_categories[index].isDefault) return;

    _categories.removeAt(index);

    notifyListeners();
  }
}