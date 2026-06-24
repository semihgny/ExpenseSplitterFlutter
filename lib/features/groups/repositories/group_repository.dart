import 'package:drift/drift.dart';
import '../../../../services/database/app_database.dart';

class GroupRepository {
  final AppDatabase _db;

  GroupRepository(this._db);

  // Get all groups as a stream for reactive UI
  Stream<List<Group>> watchAllGroups() {
    return _db.select(_db.groupsTable).watch();
  }

  // Get a specific group by ID
  Future<Group> getGroupById(int id) async {
    return await (_db.select(_db.groupsTable)..where((t) => t.id.equals(id))).getSingle();
  }

  // Create a new group
  Future<int> createGroup({required String name, String? category}) async {
    return await _db.into(_db.groupsTable).insert(
      GroupsTableCompanion.insert(
        name: name,
        category: Value(category),
      ),
    );
  }

  // Update a group
  Future<bool> updateGroup(Group group) async {
    return await _db.update(_db.groupsTable).replace(group);
  }

  // Delete a group
  Future<int> deleteGroup(int id) async {
    return await _db.transaction(() async {
      // 1. Harcamaları sil (payerId hatası vermemesi için önce harcamalar silinmeli)
      await (_db.delete(_db.expensesTable)..where((t) => t.groupId.equals(id))).go();
      
      // 2. Üyeleri sil
      await (_db.delete(_db.membersTable)..where((t) => t.groupId.equals(id))).go();
      
      // 3. Logları sil
      await (_db.delete(_db.logsTable)..where((t) => t.groupId.equals(id))).go();
      
      // 4. Bölümleri (Sections) sil
      await (_db.delete(_db.sectionsTable)..where((t) => t.groupId.equals(id))).go();
      
      // 5. En son grubu sil
      return await (_db.delete(_db.groupsTable)..where((t) => t.id.equals(id))).go();
    });
  }
}
