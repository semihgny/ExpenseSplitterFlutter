import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


import 'tables/groups_table.dart';
import 'tables/members_table.dart';
import 'tables/sections_table.dart';
import 'tables/expenses_table.dart';
import 'tables/expense_splits_table.dart';
import 'tables/logs_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  GroupsTable,
  MembersTable,
  SectionsTable,
  ExpensesTable,
  ExpenseSplitsTable,
  LogsTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(expensesTable, expensesTable.category);
        }
        if (from < 3) {
          try {
            await m.addColumn(groupsTable, groupsTable.category);
          } catch (e) {
            // ignore if column already exists
          }
          try {
            await m.addColumn(groupsTable, groupsTable.currency);
          } catch (e) {
            // ignore if column already exists
          }
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'masraf_bol.sqlite'));



    return NativeDatabase.createInBackground(file);
  });
}
