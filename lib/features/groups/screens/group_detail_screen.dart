import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_bottom_sheet.dart';
import '../../../shared/widgets/member_avatar.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../settings/controllers/settings_controller.dart';
import '../../expenses/screens/add_expense_sheet.dart';
import '../../expenses/screens/add_transfer_sheet.dart';
import '../controllers/group_controller.dart';
import '../controllers/member_controller.dart';
import '../../../../services/database/app_database.dart';
import '../../expenses/controllers/expense_controller.dart';
import '../../../core/localization/app_localizations.dart';

class GroupDetailScreen extends ConsumerStatefulWidget {
  final String groupId;
  
  const GroupDetailScreen({super.key, required this.groupId});

  @override
  ConsumerState<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

enum SortOption { dateDesc, dateAsc, amountDesc, amountAsc }

class _GroupDetailScreenState extends ConsumerState<GroupDetailScreen> {
  String? _expandedSection = 'Genel'; 
  bool _isFlatView = false;
  SortOption _sortOption = SortOption.dateDesc;

  @override
  Widget build(BuildContext context) {
    final groupIdInt = int.tryParse(widget.groupId) ?? 0;
    
    // Watch providers
    final groupsAsync = ref.watch(groupsProvider);
    final membersAsync = ref.watch(groupMembersProvider(groupIdInt));
    final expensesAsync = ref.watch(groupExpensesProvider(groupIdInt));
    final settings = ref.watch(settingsControllerProvider);
    final currency = Currency.fromCode(settings.currency) ?? Currency.tl;
    final loc = ref.watch(localizationsProvider);
    
    final groupSplitsAsync = ref.watch(groupAllSplitsProvider(groupIdInt));
    final groupSplits = groupSplitsAsync.value ?? [];
    
    String groupName = 'Yükleniyor...';
    if (groupsAsync.hasValue) {
      final group = groupsAsync.value!.firstWhere((g) => g.id == groupIdInt);
      groupName = group.name;
    }
    
    final expenses = expensesAsync.value ?? [];
    final members = membersAsync.value ?? [];
    
    final totalAmount = expenses.fold(0.0, (sum, e) => sum + e.amount);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Area: Group Header
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.md),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary, size: 28),
                          onPressed: () => context.pop(),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                Text(
                                  groupName,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${loc.translate('total')}: ${Formatters.currency(totalAmount, currency)} • ${members.length} ${loc.translate('members')}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.push('/personal/group/${widget.groupId}/result');
                          },
                          icon: const Icon(Icons.calculate_outlined, size: 18),
                          label: Text(loc.translate('calculate')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            minimumSize: Size.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Members Horizontal Scroll
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.lg, left: AppSpacing.md, right: AppSpacing.md),
                    child: membersAsync.when(
                      data: (m) => _buildMembersRow(m, context, ref, loc),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, st) => Text('Hata: \$e'),
                    ),
                  ),
                ],
              ),
            ),
            
            // View Toggle & Sort Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // View Toggle
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      borderRadius: AppRadius.borderMd,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _isFlatView = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: !_isFlatView ? Theme.of(context).colorScheme.surface : Colors.transparent,
                              borderRadius: AppRadius.borderSm,
                              boxShadow: !_isFlatView ? AppShadows.light : null,
                            ),
                            child: Icon(Icons.folder_outlined, size: 20, color: !_isFlatView ? Theme.of(context).colorScheme.primary : Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _isFlatView = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _isFlatView ? Theme.of(context).colorScheme.surface : Colors.transparent,
                              borderRadius: AppRadius.borderSm,
                              boxShadow: _isFlatView ? AppShadows.light : null,
                            ),
                            child: Icon(Icons.format_list_bulleted, size: 20, color: _isFlatView ? Theme.of(context).colorScheme.primary : Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Sort Button (only in flat view)
                  if (_isFlatView)
                    PopupMenuButton<SortOption>(
                      initialValue: _sortOption,
                      onSelected: (option) => setState(() => _sortOption = option),
                      icon: Icon(Icons.sort, color: Theme.of(context).colorScheme.primary),
                      itemBuilder: (context) => [
                        PopupMenuItem(value: SortOption.dateDesc, child: Text(loc.translate('sort_newest'))),
                        PopupMenuItem(value: SortOption.dateAsc, child: Text(loc.translate('sort_oldest'))),
                        PopupMenuItem(value: SortOption.amountDesc, child: Text(loc.translate('sort_amount_desc'))),
                        PopupMenuItem(value: SortOption.amountAsc, child: Text(loc.translate('sort_amount_asc'))),
                      ],
                    ),
                ],
              ),
            ),
            
            // Main Content: Expenses Accordion or Flat List
            Expanded(
              child: expenses.isEmpty
                  ? Center(
                      child: Text(
                        loc.translate('no_expense'),
                        style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6)),
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.only(top: AppSpacing.xs, left: AppSpacing.md, right: AppSpacing.md, bottom: 100),
                      children: _isFlatView 
                          ? _buildFlatExpenses(expenses, members, groupSplits, currency, loc)
                          : _buildGroupedExpenses(expenses, members, groupSplits, currency, loc),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, right: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 56,
              height: 56,
              child: FloatingActionButton(
                heroTag: 'transfer_btn',
                backgroundColor: const Color(0xFFF3E5F5),
                foregroundColor: const Color(0xFF6A1B9A),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                onPressed: () {
                  AppBottomSheet.show(
                    context: context,
                    isDraggable: true,
                    title: loc.translate('add_transfer') == 'add_transfer' ? 'Borç / Ödeme Ekle' : loc.translate('add_transfer'),
                    child: AddTransferSheet(groupId: groupIdInt),
                  );
                },
                child: const Icon(Icons.sync_alt, size: 28),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 64,
              height: 64,
              child: FloatingActionButton(
                heroTag: 'expense_btn',
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  AppBottomSheet.show(
                    context: context,
                    isDraggable: true,
                    title: loc.translate('new_expense'),
                    child: AddExpenseSheet(groupId: groupIdInt),
                  );
                },
                child: const Icon(Icons.add, size: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFlatExpenses(List<dynamic> expenses, List<dynamic> members, List<dynamic> groupSplits, Currency currency, AppLocalizations loc) {
    // Sort expenses
    final sortedExpenses = List<dynamic>.from(expenses);
    sortedExpenses.sort((a, b) {
      switch (_sortOption) {
        case SortOption.dateDesc:
          return (b.createdAt as DateTime).compareTo(a.createdAt as DateTime);
        case SortOption.dateAsc:
          return (a.createdAt as DateTime).compareTo(b.createdAt as DateTime);
        case SortOption.amountDesc:
          return (b.amount as double).compareTo(a.amount as double);
        case SortOption.amountAsc:
          return (a.amount as double).compareTo(b.amount as double);
      }
    });

    return sortedExpenses.map((e) {
      final payer = members.cast<Member?>().firstWhere(
        (m) => m!.id.toString() == e.payerId,
        orElse: () => null,
      );
      final payerName = payer?.name ?? loc.translate('unknown');
      return Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).colorScheme.surfaceContainerLow),
          boxShadow: const [
            BoxShadow(
              color: Color(0x05000000),
              blurRadius: 10,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: _buildExpenseItem(
          title: e.description ?? loc.translate('expense'),
          payerName: payerName,
          amount: Formatters.currency(e.amount, currency),
          date: loc.translate(Formatters.dateRelative(e.createdAt as DateTime)),
          status: loc.translate('paid'),
          statusColor: Colors.green,
          dotColor: (e.category == 'category_transfer' || e.category == 'Borç / Transfer') ? Colors.green : Colors.red,
          onLongPress: () {
            final expenseSplits = groupSplits.where((s) => s.expenseId == e.id).toList();
            _showExpenseActionSheet(context, ref, e, expenseSplits, loc);
          },
        ),
      );
    }).toList();
  }

  List<Widget> _buildGroupedExpenses(List<dynamic> expenses, List<dynamic> members, List<dynamic> groupSplits, Currency currency, AppLocalizations loc) {
    // Map expenses by category
    final Map<String, List<dynamic>> grouped = {};
    for (final exp in expenses) {
      final cat = exp.category ?? 'Genel';
      grouped.putIfAbsent(cat, () => []).add(exp);
    }
    
    final widgets = <Widget>[];
    
    grouped.forEach((category, catExpenses) {
      final totalCatAmount = catExpenses.fold(0.0, (sum, e) => sum + e.amount);
      
      IconData icon;
      Color iconColor;
      Color iconBgColor;
      
      switch (category) {
        case 'category_transfer':
        case 'Borç / Transfer':
          icon = Icons.sync_alt;
          iconColor = const Color(0xFF6A1B9A);
          iconBgColor = const Color(0xFFF3E5F5);
          break;
        case 'Yemek':
          icon = Icons.restaurant;
          iconColor = const Color(0xFFE65100);
          iconBgColor = const Color(0xFFFFF3E0);
          break;
        case 'Ulaşım':
          icon = Icons.directions_car;
          iconColor = const Color(0xFF1565C0);
          iconBgColor = const Color(0xFFE3F2FD);
          break;
        case 'Market':
          icon = Icons.shopping_cart;
          iconColor = const Color(0xFF2E7D32);
          iconBgColor = const Color(0xFFE8F5E9);
          break;
        default:
          icon = Icons.receipt_long;
          iconColor = const Color(0xFFE65100);
          iconBgColor = const Color(0xFFFFF3E0);
      }
      
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: _buildAccordionSection(
            id: category,
            title: loc.translate(category),
            icon: icon,
            iconColor: iconColor,
            iconBgColor: iconBgColor,
            totalAmount: Formatters.currency(totalCatAmount, currency),
            isExpanded: _expandedSection == category,
            onToggle: () {
              setState(() {
                _expandedSection = _expandedSection == category ? null : category;
              });
            },
            children: catExpenses.map((e) {
              final payer = members.cast<Member?>().firstWhere(
                (m) => m!.id.toString() == e.payerId,
                orElse: () => null,
              );
              final payerName = payer?.name ?? loc.translate('unknown');
              return _buildExpenseItem(
                title: e.description ?? loc.translate('expense'),
                payerName: payerName,
                amount: Formatters.currency(e.amount, currency),
                date: loc.translate(Formatters.dateRelative(e.createdAt as DateTime)),
                status: loc.translate('paid'),
                statusColor: Colors.green,
                dotColor: (e.category == 'category_transfer' || e.category == 'Borç / Transfer') ? Colors.green : Colors.red,
                onLongPress: () {
                  final expenseSplits = groupSplits.where((s) => s.expenseId == e.id).toList();
                  _showExpenseActionSheet(context, ref, e, expenseSplits, loc);
                },
              );
            }).toList(),
          ),
        )
      );
    });
    
    return widgets;
  }

  Widget _buildMembersRow(List members, BuildContext context, WidgetRef ref, AppLocalizations loc) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primaryContainer),
                  onPressed: () async {
                    await _showAddMemberDialog(int.tryParse(widget.groupId) ?? 0);
                  },
                ),
              ),
              const SizedBox(height: 4),
              Text(
                loc.translate('add'),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          ...members.map((member) => Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: GestureDetector(
              onTap: () => _showMemberDetailSheet(context, ref, member, loc),
              onLongPress: () => _showMemberActionSheet(context, ref, member, loc),
              child: Column(
                children: [
                  MemberAvatar(name: member.name),
                  const SizedBox(height: AppSpacing.xs),
                  SizedBox(
                    width: 56, // Same as avatar size
                    child: Text(
                      member.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  void _showMemberDetailSheet(BuildContext context, WidgetRef ref, dynamic member, AppLocalizations loc) {
    AppBottomSheet.show(
      context: context,
      title: '${member.name} İstatistikleri',
      child: Consumer(
        builder: (context, ref, child) {
          final expenses = ref.watch(groupExpensesProvider(int.tryParse(widget.groupId) ?? 0)).value ?? [];
          final splits = ref.watch(groupAllSplitsProvider(int.tryParse(widget.groupId) ?? 0)).value ?? [];
          final settings = ref.watch(settingsControllerProvider);
          final currency = Currency.fromCode(settings.currency) ?? Currency.tl;

          double totalPaid = 0;
          for (final exp in expenses) {
            if (exp.payerId == member.id.toString()) {
              totalPaid += exp.amount;
            }
          }

          double totalOwed = 0;
          for (final split in splits) {
            if (split.memberId == member.id.toString()) {
              totalOwed += split.amount;
            }
          }

          final netBalance = totalPaid - totalOwed;
          final isPositive = netBalance >= 0;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MemberAvatar(name: member.name, size: MemberAvatarSize.regular),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(loc.translate('total_paid'), style: const TextStyle(fontWeight: FontWeight.w500)),
                  Text(
                    Formatters.currency(totalPaid, currency),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(loc.translate('share_owed'), style: const TextStyle(fontWeight: FontWeight.w500)),
                  Text(
                    Formatters.currency(totalOwed, currency),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              const Divider(),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(loc.translate('net_status'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(
                    '${Formatters.currency(netBalance.abs(), currency)} ${isPositive ? loc.translate('creditor') : loc.translate('debtor')}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isPositive ? Colors.green : Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showAddMemberDialog(int groupId) async {
    final TextEditingController controller = TextEditingController();
    final loc = ref.read(localizationsProvider);
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.translate('add_member')),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: loc.translate('member_name')),
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.translate('cancel')),
          ),
          FilledButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await ref.read(memberControllerProvider.notifier).addMember(
                  groupId: groupId,
                  name: controller.text.trim(),
                );
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: Text(loc.translate('add')),
          ),
        ],
      ),
    );
  }

  void _showMemberActionSheet(BuildContext context, WidgetRef ref, dynamic member, AppLocalizations loc) {
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
                _showEditMemberDialog(member, loc);
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
                    title: Text(loc.translate('delete_user_title')),
                    content: Text(loc.translate('delete_user_confirm')),
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
                    await ref.read(memberControllerProvider.notifier).deleteMember(member.id.toString());
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(loc.translate('cannot_delete_member') ?? 'Bu kullanıcı silinemez çünkü harcamalara dahil.')),
                      );
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

  Future<void> _showEditMemberDialog(dynamic member, AppLocalizations loc) async {
    final controller = TextEditingController(text: member.name);
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(loc.translate('edit')),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: loc.translate('group_name')),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(loc.translate('cancel')),
          ),
          FilledButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                final updated = member.copyWith(name: controller.text.trim());
                await ref.read(memberControllerProvider.notifier).updateMember(updated);
                if (dialogContext.mounted) Navigator.pop(dialogContext);
              }
            },
            child: Text(loc.translate('edit')),
          ),
        ],
      ),
    );
  }

  Widget _buildAccordionSection({
    required String id,
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String totalAmount,
    required bool isExpanded,
    required VoidCallback onToggle,
    required List<Widget> children,
  }) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: isExpanded 
                ? const BorderRadius.vertical(top: Radius.circular(16)) 
                : BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: iconColor),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '$totalAmount ${ref.read(localizationsProvider).translate('total').toLowerCase()}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Column(children: children),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem({
    required String title,
    required String payerName,
    required String amount,
    required String date,
    required String status,
    required Color statusColor,
    required Color dotColor,
    required VoidCallback onLongPress,
  }) {
    final loc = ref.read(localizationsProvider);
    return InkWell(
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
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
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '$payerName ${loc.translate('paid')} • $date',
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
                amount,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Row(
                children: [
                  Icon(Icons.check_circle, size: 12, color: statusColor),
                  const SizedBox(width: 4),
                  Text(
                    status,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: statusColor),
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

  void _showExpenseActionSheet(BuildContext context, WidgetRef ref, dynamic expense, List<dynamic> expenseSplits, AppLocalizations loc) {
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
                final isTransfer = expense.category == 'category_transfer' || expense.category == 'Borç / Transfer';
                AppBottomSheet.show(
                  context: context,
                  isDraggable: true,
                  title: loc.translate('edit'),
                  child: isTransfer
                      ? AddTransferSheet(
                          groupId: expense.groupId,
                          existingExpense: expense,
                          existingSplits: expenseSplits.cast(),
                        )
                      : AddExpenseSheet(
                          groupId: expense.groupId,
                          existingExpense: expense,
                          existingSplits: expenseSplits.cast(),
                        ),
                );
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
                    content: Text(loc.translate('delete_expense_confirm')),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(loc.translate('cancel')),
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(loc.translate('delete')),
                      ),
                    ],
                  ),
                );

                if (confirm == true && context.mounted) {
                  await ref.read(expenseControllerProvider.notifier).deleteExpense(expense.id);
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
