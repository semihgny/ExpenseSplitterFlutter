import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_sheet.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../settings/controllers/settings_controller.dart';
import '../controllers/group_controller.dart';
import '../controllers/member_controller.dart';
import '../../expenses/controllers/expense_controller.dart';
import 'create_group_sheet.dart';
import '../../../core/localization/app_localizations.dart';

class PersonalScreen extends ConsumerWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(groupsProvider);
    final settings = ref.watch(settingsControllerProvider);
    final currency = Currency.fromCode(settings.currency) ?? Currency.tl;
    final loc = ref.watch(localizationsProvider);
    
    // Calculate total balance from all groups
    double totalBalance = 0;
    if (groupsAsync.hasValue) {
      for (final group in groupsAsync.value!) {
        final expensesAsync = ref.watch(groupExpensesProvider(group.id));
        if (expensesAsync.hasValue) {
          totalBalance += expensesAsync.value!.fold(0.0, (sum, e) => sum + e.amount);
        }
      }
    }
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        elevation: 0,
        title: Text(
          loc.translate('app_name'),
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.primary,
            fontSize: 26,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              showSearch(context: context, delegate: _GroupSearchDelegate(groupsAsync.value ?? []));
            },
          ),
          IconButton(
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              AppBottomSheet.show(
                context: context,
                title: loc.translate('new_group'),
                child: const CreateGroupSheet(),
              );
            },
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Total Balance CardMain Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Total Balance Bento Card
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0D000000), // rgba(0,0,0,0.05)
                            blurRadius: 20,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            loc.translate('total_balance'),
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            Formatters.currency(totalBalance, currency),
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                          ),
                        ],
                      ),
                    ),
                    // Section Title
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm, left: AppSpacing.xs),
                      child: Text(
                        loc.translate('my_groups'),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                      ),
                    ),
                    
                    // Group Cards
                    groupsAsync.when(
                      data: (groups) {
                        if (groups.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.xl),
                              child: Text(loc.translate('no_group')),
                            ),
                          );
                        }
                        
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: groups.length,
                          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
                          itemBuilder: (context, index) {
                            return _GroupCardConsumer(group: groups[index], currency: currency);
                          },
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text('Hata: \$err')),
                    ),
                    
                    const SizedBox(height: 100), // Padding for FAB
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, right: 8.0),
        child: SizedBox(
          width: 56,
          height: 56,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            elevation: 8, // shadow-lg equivalent
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onPressed: () {
              AppBottomSheet.show(
                context: context,
                isDraggable: true,
                title: loc.translate('new_group'),
                child: const CreateGroupSheet(),
              );
            },
            child: const Icon(Icons.add, size: 28),
          ),
        ),
      ),
    );
  }
}

class _GroupCardConsumer extends ConsumerWidget {
  final dynamic group;
  final Currency currency;

  const _GroupCardConsumer({required this.group, required this.currency});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = ref.watch(localizationsProvider);
    final expensesAsync = ref.watch(groupExpensesProvider(group.id));
    final membersAsync = ref.watch(groupMembersProvider(group.id));

    final expenses = expensesAsync.value ?? [];
    final members = membersAsync.value ?? [];
    
    final totalAmount = expenses.fold(0.0, (sum, e) => sum + e.amount);

    return InkWell(
      onTap: () => context.go('/personal/group/${group.id}'),
      onLongPress: () => _showGroupActionSheet(context, ref, group, loc),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(minHeight: 100),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).colorScheme.surfaceContainerLow),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 20,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    group.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  Formatters.currency(totalAmount, currency),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.group_outlined, size: 16, color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6)),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '${members.length} ${loc.translate('members')}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                          ),
                    ),
                  ],
                ),
                const SizedBox(width: AppSpacing.md),
                Row(
                  children: [
                    Icon(Icons.receipt_long_outlined, size: 16, color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6)),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '${expenses.length} ${loc.translate('expenses')}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showGroupActionSheet(BuildContext context, WidgetRef ref, dynamic group, AppLocalizations loc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 48,
              height: 6,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
              title: Text(loc.translate('edit')),
              onTap: () {
                Navigator.pop(sheetContext);
                _showEditGroupDialog(context, ref, group, loc);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
              title: Text(loc.translate('delete'), style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () async {
                Navigator.pop(sheetContext);
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: Text(loc.translate('delete')),
                    content: Text(loc.translate('delete_group_confirm')),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext, false),
                        child: Text(loc.translate('cancel')),
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
                        onPressed: () => Navigator.pop(dialogContext, true),
                        child: Text(loc.translate('delete')),
                      ),
                    ],
                  ),
                );

                if (confirm == true && context.mounted) {
                  try {
                    await ref.read(groupControllerProvider.notifier).deleteGroup(group.id);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hata: $e')));
                    }
                  }
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditGroupDialog(BuildContext context, WidgetRef ref, dynamic group, AppLocalizations loc) async {
    final controller = TextEditingController(text: group.name);
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(loc.translate('edit')),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: loc.translate('group_name')),
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(loc.translate('cancel')),
          ),
          FilledButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                final updatedGroup = group.copyWith(name: controller.text.trim());
                await ref.read(groupControllerProvider.notifier).updateGroup(updatedGroup);
                if (dialogContext.mounted) Navigator.pop(dialogContext);
              }
            },
            child: Text(loc.translate('edit')),
          ),
        ],
      ),
    );
  }
}

class _GroupSearchDelegate extends SearchDelegate {
  final List<dynamic> groups;
  _GroupSearchDelegate(this.groups);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    final filtered = groups.where((g) => g.name.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final group = filtered[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  group.name.isNotEmpty ? group.name.substring(0, 1).toUpperCase() : '?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            title: Text(
              group.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.secondary),
            onTap: () {
              final groupId = group.id;
              close(context, null);
              GoRouter.of(context).push('/personal/group/$groupId');
            },
          ),
        );
      },
    );
  }
}
