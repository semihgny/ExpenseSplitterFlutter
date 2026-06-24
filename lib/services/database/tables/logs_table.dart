import 'package:drift/drift.dart';
import 'groups_table.dart';

@DataClassName('Log')
class LogsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get action => text()(); // e.g., 'expense_added', 'group_created'
  TextColumn get description => text()();
  TextColumn get memberName => text().nullable()();
  RealColumn get amount => real().nullable()();
  IntColumn get groupId => integer().references(GroupsTable, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
