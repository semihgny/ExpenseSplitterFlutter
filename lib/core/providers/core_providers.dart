import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/database/app_database.dart';

/// Provides the singleton instance of the AppDatabase.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});
