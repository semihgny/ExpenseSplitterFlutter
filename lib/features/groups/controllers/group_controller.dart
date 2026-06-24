import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../services/database/app_database.dart';
import '../repositories/group_repository.dart';

// Provider for the GroupRepository
final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return GroupRepository(db);
});

// Provider that watches all groups (Reactive stream)
final groupsProvider = StreamProvider<List<Group>>((ref) {
  final repository = ref.watch(groupRepositoryProvider);
  return repository.watchAllGroups();
});

// GroupController for mutations
class GroupController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // nothing to initialize
  }

  Future<void> createGroup({required String name, String? category}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(groupRepositoryProvider);
      await repository.createGroup(name: name, category: category);
    });
  }

  Future<void> deleteGroup(int id) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(groupRepositoryProvider);
      await repository.deleteGroup(id);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> updateGroup(Group group) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(groupRepositoryProvider);
      await repository.updateGroup(group);
    });
  }
}

// Provider for the GroupController
final groupControllerProvider = AsyncNotifierProvider<GroupController, void>(GroupController.new);
