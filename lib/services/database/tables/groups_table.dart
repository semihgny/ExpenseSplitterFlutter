import 'package:drift/drift.dart';

@DataClassName('Group')
class GroupsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get category => text().nullable()();
  TextColumn get currency => text().withDefault(const Constant('TRY'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
