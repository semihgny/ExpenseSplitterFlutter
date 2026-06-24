import 'package:drift/drift.dart';
import '../../../../services/database/app_database.dart';

class ExpenseRepository {
  final AppDatabase _db;

  ExpenseRepository(this._db);

  // Watch all expenses globally (for Logs)
  Stream<List<Expense>> watchAllExpenses() {
    return (_db.select(_db.expensesTable)
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)]))
      .watch();
  }

  // Watch all expenses for a specific group
  Stream<List<Expense>> watchGroupExpenses(int groupId) {
    return (_db.select(_db.expensesTable)..where((t) => t.groupId.equals(groupId))).watch();
  }

  // Watch all expense splits for a specific group
  Stream<List<ExpenseSplit>> watchGroupSplits(int groupId) {
    final query = _db.select(_db.expenseSplitsTable).join([
      innerJoin(_db.expensesTable, _db.expensesTable.id.equalsExp(_db.expenseSplitsTable.expenseId)),
    ])..where(_db.expensesTable.groupId.equals(groupId));

    return query.watch().map((rows) => rows.map((row) => row.readTable(_db.expenseSplitsTable)).toList());
  }

  // Watch expense splits for a specific expense
  Stream<List<ExpenseSplit>> watchExpenseSplits(int expenseId) {
    return (_db.select(_db.expenseSplitsTable)..where((t) => t.expenseId.equals(expenseId))).watch();
  }

  Future<int> addExpenseWithSplits({
    required ExpensesTableCompanion expense,
    required List<ExpenseSplitsTableCompanion> splits,
  }) async {
    return await _db.transaction(() async {
      // Insert the expense and get the generated ID
      final expenseId = await _db.into(_db.expensesTable).insert(expense);
      
      // Insert all splits linked to the new expense ID
      for (final split in splits) {
        await _db.into(_db.expenseSplitsTable).insert(
          split.copyWith(expenseId: Value(expenseId)),
        );
      }
      
      return expenseId;
    });
  }

  Future<void> updateExpenseWithSplits({
    required ExpensesTableCompanion expense,
    required List<ExpenseSplitsTableCompanion> splits,
  }) async {
    await _db.transaction(() async {
      // Update the expense
      await _db.update(_db.expensesTable).replace(expense);
      
      // Delete existing splits for this expense
      await (_db.delete(_db.expenseSplitsTable)..where((t) => t.expenseId.equals(expense.id.value))).go();
      
      // Insert new splits
      for (final split in splits) {
        await _db.into(_db.expenseSplitsTable).insert(
          split.copyWith(expenseId: expense.id),
        );
      }
    });
  }

  // Delete an expense (Cascade will automatically delete splits)
  Future<int> deleteExpense(int id) async {
    return await (_db.delete(_db.expensesTable)..where((t) => t.id.equals(id))).go();
  }

  // Clear all expenses for a specific group (Cascade will delete splits)
  Future<void> clearGroupDebts(int groupId) async {
    await (_db.delete(_db.expensesTable)..where((t) => t.groupId.equals(groupId))).go();
  }
}
