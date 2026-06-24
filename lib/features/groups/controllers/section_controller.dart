import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../services/database/app_database.dart';
import '../repositories/section_repository.dart';

// Provider for the SectionRepository
final sectionRepositoryProvider = Provider<SectionRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return SectionRepository(db);
});

// Provider that watches sections for a specific group
final groupSectionsProvider = StreamProvider.family<List<Section>, int>((ref, groupId) {
  final repository = ref.watch(sectionRepositoryProvider);
  return repository.watchGroupSections(groupId);
});

class SectionController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // nothing to initialize
  }

  Future<void> createSection({
    required String name,
    required String icon,
    required int groupId,
    String? iconBgColor,
    String? iconColor,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(sectionRepositoryProvider);
      await repository.createSection(
        name: name,
        icon: icon,
        groupId: groupId,
        iconBgColor: iconBgColor,
        iconColor: iconColor,
      );
    });
  }

  Future<void> deleteSection(int id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(sectionRepositoryProvider);
      await repository.deleteSection(id);
    });
  }
}

final sectionControllerProvider = AsyncNotifierProvider<SectionController, void>(SectionController.new);
