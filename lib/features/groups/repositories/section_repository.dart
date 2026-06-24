import 'package:drift/drift.dart';
import '../../../../services/database/app_database.dart';

class SectionRepository {
  final AppDatabase _db;

  SectionRepository(this._db);

  // Get sections for a specific group
  Stream<List<Section>> watchGroupSections(int groupId) {
    return (_db.select(_db.sectionsTable)..where((t) => t.groupId.equals(groupId))).watch();
  }

  // Create a section
  Future<int> createSection({
    required String name,
    required String icon,
    required int groupId,
    String? iconBgColor,
    String? iconColor,
  }) async {
    return await _db.into(_db.sectionsTable).insert(
      SectionsTableCompanion.insert(
        name: name,
        icon: icon,
        groupId: groupId,
        iconBgColor: Value(iconBgColor),
        iconColor: Value(iconColor),
      ),
    );
  }

  // Delete a section
  Future<int> deleteSection(int id) async {
    return await (_db.delete(_db.sectionsTable)..where((t) => t.id.equals(id))).go();
  }
}
