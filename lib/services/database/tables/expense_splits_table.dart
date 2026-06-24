import 'package:drift/drift.dart';
import 'members_table.dart';
import 'expenses_table.dart';

@DataClassName('ExpenseSplit')
class ExpenseSplitsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get memberId => text().references(MembersTable, #id)();
  RealColumn get percentage => real()();
  RealColumn get amount => real()();
  IntColumn get expenseId => integer().references(ExpensesTable, #id, onDelete: KeyAction.cascade)();
}
