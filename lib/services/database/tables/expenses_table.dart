import 'package:drift/drift.dart';
import 'groups_table.dart';
import 'members_table.dart';
import 'sections_table.dart';

@DataClassName('Expense')
class ExpensesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  RealColumn get amount => real()();
  TextColumn get payerId => text().references(MembersTable, #id)();
  TextColumn get description => text().nullable()();
  TextColumn get category => text().nullable()();
  TextColumn get splitType => text().withDefault(const Constant('equal'))(); // 'equal' or 'percentage'
  IntColumn get sectionId => integer().nullable().references(SectionsTable, #id)();
  IntColumn get groupId => integer().references(GroupsTable, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
