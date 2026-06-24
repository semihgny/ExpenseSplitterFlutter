import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../services/database/app_database.dart';
import '../repositories/member_repository.dart';

// Provider for the MemberRepository
final memberRepositoryProvider = Provider<MemberRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return MemberRepository(db);
});

// Provider that watches members for a specific group
final groupMembersProvider = StreamProvider.family<List<Member>, int>((ref, groupId) {
  final repository = ref.watch(memberRepositoryProvider);
  return repository.watchGroupMembers(groupId);
});

class MemberController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // nothing to initialize
  }

  Future<void> addMember({required String name, required int groupId, String? avatarColor}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(memberRepositoryProvider);
      await repository.addMember(name: name, groupId: groupId, avatarColor: avatarColor);
    });
  }

  Future<void> updateMember(Member member) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(memberRepositoryProvider);
      await repository.updateMember(member);
    });
  }

  Future<void> deleteMember(String id) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(memberRepositoryProvider);
      await repository.deleteMember(id);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}

final memberControllerProvider = AsyncNotifierProvider<MemberController, void>(MemberController.new);
