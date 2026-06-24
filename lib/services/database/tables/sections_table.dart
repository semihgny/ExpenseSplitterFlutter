import 'package:drift/drift.dart';
import 'groups_table.dart';

@DataClassName('Section')
class SectionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get icon => text()();
  TextColumn get iconBgColor => text().nullable()();
  TextColumn get iconColor => text().nullable()();
  IntColumn get groupId => integer().references(GroupsTable, #id, onDelete: KeyAction.cascade)();
}
