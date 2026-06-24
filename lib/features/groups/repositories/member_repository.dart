import 'package:drift/drift.dart';
import '../../../../services/database/app_database.dart';
import 'package:uuid/uuid.dart';

class MemberRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  MemberRepository(this._db);

  // Get members for a specific group
  Stream<List<Member>> watchGroupMembers(int groupId) {
    return (_db.select(_db.membersTable)..where((t) => t.groupId.equals(groupId))).watch();
  }

  // Add a member to a group
  Future<String> addMember({required String name, required int groupId, String? avatarColor}) async {
    final id = _uuid.v4();
    await _db.into(_db.membersTable).insert(
      MembersTableCompanion.insert(
        id: id,
        name: name,
        groupId: groupId,
        avatarColor: Value(avatarColor),
      ),
    );
    return id;
  }

  // Update a member
  Future<bool> updateMember(Member member) async {
    return await _db.update(_db.membersTable).replace(member);
  }

  // Delete a member
  Future<int> deleteMember(String id) async {
    return await (_db.delete(_db.membersTable)..where((t) => t.id.equals(id))).go();
  }
}
