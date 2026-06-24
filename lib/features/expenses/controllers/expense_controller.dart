import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../services/database/app_database.dart';
import '../repositories/expense_repository.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ExpenseRepository(db);
});

final allExpensesProvider = StreamProvider<List<Expense>>((ref) {
  final repository = ref.watch(expenseRepositoryProvider);
  return repository.watchAllExpenses();
});

final groupExpensesProvider = StreamProvider.family<List<Expense>, int>((ref, groupId) {
  final repository = ref.watch(expenseRepositoryProvider);
  return repository.watchGroupExpenses(groupId);
});

final groupAllSplitsProvider = StreamProvider.family<List<ExpenseSplit>, int>((ref, groupId) {
  final repository = ref.watch(expenseRepositoryProvider);
  return repository.watchGroupSplits(groupId);
});

final expenseSplitsProvider = StreamProvider.family<List<ExpenseSplit>, int>((ref, expenseId) {
  final repository = ref.watch(expenseRepositoryProvider);
  return repository.watchExpenseSplits(expenseId);
});

class ExpenseController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // nothing to initialize
  }

  Future<void> addExpenseWithSplits({
    required ExpensesTableCompanion expense,
    required List<ExpenseSplitsTableCompanion> splits,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(expenseRepositoryProvider);
      await repository.addExpenseWithSplits(expense: expense, splits: splits);
    });
  }

  Future<void> updateExpenseWithSplits({
    required ExpensesTableCompanion expense,
    required List<ExpenseSplitsTableCompanion> splits,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(expenseRepositoryProvider);
      await repository.updateExpenseWithSplits(expense: expense, splits: splits);
    });
  }

  Future<void> deleteExpense(int id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(expenseRepositoryProvider);
      await repository.deleteExpense(id);
    });
  }

  Future<void> clearGroupDebts(int groupId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(expenseRepositoryProvider);
      await repository.clearGroupDebts(groupId);
    });
  }
}

final expenseControllerProvider = AsyncNotifierProvider<ExpenseController, void>(ExpenseController.new);
