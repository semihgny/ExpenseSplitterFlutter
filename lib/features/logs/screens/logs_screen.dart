import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../settings/controllers/settings_controller.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/member_avatar.dart';
import '../../expenses/controllers/expense_controller.dart';
import '../../groups/controllers/member_controller.dart';

import '../../../core/localization/app_localizations.dart';

enum LogSortOption { newest, oldest, amountDesc, amountAsc }

class LogsScreen extends ConsumerStatefulWidget {
  const LogsScreen({super.key});

  @override
  ConsumerState<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends ConsumerState<LogsScreen> {
  LogSortOption _sortOption = LogSortOption.newest;

  @override
  Widget build(BuildContext context) {
    final expensesAsync = ref.watch(allExpensesProvider);
    final loc = ref.watch(localizationsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text(loc.translate('tab_history')),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showSortOptions,
          ),
        ],
      ),
      body: expensesAsync.when(
        data: (expenses) {
          if (expenses.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Text(loc.translate('no_expense_log')),
              ),
            );
          }

          var sortedExpenses = List.of(expenses);
          switch (_sortOption) {
            case LogSortOption.newest:
              sortedExpenses.sort((a, b) => b.createdAt.compareTo(a.createdAt));
              break;
            case LogSortOption.oldest:
              sortedExpenses.sort((a, b) => a.createdAt.compareTo(b.createdAt));
              break;
            case LogSortOption.amountDesc:
              sortedExpenses.sort((a, b) => b.amount.compareTo(a.amount));
              break;
            case LogSortOption.amountAsc:
              sortedExpenses.sort((a, b) => a.amount.compareTo(b.amount));
              break;
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: sortedExpenses.length,
            itemBuilder: (context, index) {
              final expense = sortedExpenses[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _LogItemConsumer(expense: expense),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Hata: $err')),
      ),
    );
  }

  void _showSortOptions() {
    final loc = ref.read(localizationsProvider);
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(loc.translate('sort'), style: Theme.of(context).textTheme.titleMedium),
              ),
              ListTile(
                title: Text(loc.translate('sort_newest')),
                trailing: _sortOption == LogSortOption.newest ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                onTap: () {
                  setState(() => _sortOption = LogSortOption.newest);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(loc.translate('sort_oldest')),
                trailing: _sortOption == LogSortOption.oldest ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                onTap: () {
                  setState(() => _sortOption = LogSortOption.oldest);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(loc.translate('sort_amount_desc')),
                trailing: _sortOption == LogSortOption.amountDesc ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                onTap: () {
                  setState(() => _sortOption = LogSortOption.amountDesc);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(loc.translate('sort_amount_asc')),
                trailing: _sortOption == LogSortOption.amountAsc ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                onTap: () {
                  setState(() => _sortOption = LogSortOption.amountAsc);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LogItemConsumer extends ConsumerWidget {
  final dynamic expense;

  const _LogItemConsumer({required this.expense});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = ref.watch(localizationsProvider);
    final settings = ref.watch(settingsControllerProvider);
    final currency = Currency.fromCode(settings.currency) ?? Currency.tl;
    // Attempt to get the member to show name
    final membersAsync = ref.watch(groupMembersProvider(expense.groupId));
    String payerName = loc.translate('members'); // Or 'Unknown'
    
    if (membersAsync.hasValue) {
      try {
        payerName = membersAsync.value!.firstWhere((m) => m.id.toString() == expense.payerId).name;
      } catch (_) {}
    }

    final isTransfer = expense.category == 'category_transfer' || expense.category == 'Borç / Transfer';
    final dotColor = isTransfer ? Colors.green : Colors.red;

    return AppCard(
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          MemberAvatar(
            name: payerName,
            size: MemberAvatarSize.small,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title != null && expense.title!.isNotEmpty ? expense.title! : loc.translate('expense_title_default'),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  '${expense.payerId == payerName ? payerName : payerName} ${loc.translate('paid')} • ${loc.translate(expense.category ?? 'category_general')}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                      ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                Formatters.currency(expense.amount, currency),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                loc.translate('added'),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.green,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
