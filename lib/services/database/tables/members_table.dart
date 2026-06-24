import 'package:drift/drift.dart';
import 'groups_table.dart';

@DataClassName('Member')
class MembersTable extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get name => text()();
  TextColumn get avatarColor => text().nullable()();
  IntColumn get groupId => integer().references(GroupsTable, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
