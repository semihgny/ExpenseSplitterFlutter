import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../settings/controllers/settings_controller.dart';
import '../../../core/constants/app_constants.dart';
import 'package:drift/drift.dart' hide Column;
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_input.dart';
import '../../../shared/widgets/app_bottom_sheet.dart';
import '../../../shared/widgets/member_avatar.dart';
import '../controllers/expense_controller.dart';
import '../../groups/controllers/member_controller.dart';
import '../../../../services/database/app_database.dart';
import '../../../core/localization/app_localizations.dart';

class AddExpenseSheet extends ConsumerStatefulWidget {
  final int groupId;
  final Expense? existingExpense;
  final List<ExpenseSplit>? existingSplits;
  
  const AddExpenseSheet({
    super.key, 
    required this.groupId,
    this.existingExpense,
    this.existingSplits,
  });

  @override
  ConsumerState<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<AddExpenseSheet> {
  final _amountController = TextEditingController();
  final _descController = TextEditingController();
  final Map<String, TextEditingController> _percentControllers = {};
  final Map<String, TextEditingController> _exactControllers = {};
  
  String _splitType = 'equal'; // 'equal', 'percentage', 'exact'
  String? _selectedPayerId;
  String _selectedCategory = 'category_general';
  final Set<String> _selectedMembers = {};
  bool _membersInitialized = false;
  
  final List<String> _categories = [
    'category_general', 'category_food', 'category_market', 'category_transport', 'category_entertainment', 'category_bill', 'category_health', 'category_education', 'category_other'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingExpense != null) {
      _amountController.text = widget.existingExpense!.amount.toString();
      _descController.text = widget.existingExpense!.description ?? '';
      _selectedCategory = widget.existingExpense!.category ?? 'category_general';
      _splitType = widget.existingExpense!.splitType ?? 'equal';
      
      if (widget.existingSplits != null) {
        for (final split in widget.existingSplits!) {
          if (split.percentage > 0 || split.amount > 0) {
            _selectedMembers.add(split.memberId);
          }
        }
      }
      _membersInitialized = true;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    for (var c in _percentControllers.values) {
      c.dispose();
    }
    for (var c in _exactControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final membersAsync = ref.watch(groupMembersProvider(widget.groupId));
    
    final loc = ref.watch(localizationsProvider);
    final settings = ref.watch(settingsControllerProvider);
    final currencySymbol = Currency.fromCode(settings.currency)?.symbol ?? '₺';
    
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
      ),
      child: membersAsync.when(
        data: (members) {
          if (members.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Text(loc.translate('expense_add_empty')),
            );
          }
          
          // Select first member by default
          _selectedPayerId ??= widget.existingExpense?.payerId ?? members.first.id.toString();

          if (!_membersInitialized && members.isNotEmpty) {
            _selectedMembers.addAll(members.map((m) => m.id.toString()));
            _membersInitialized = true;
          }

          // Initialize percentage and exact controllers if empty
          if (_percentControllers.isEmpty && members.isNotEmpty) {
            final defaultPct = (100.0 / members.length).toStringAsFixed(0);
            for (final m in members) {
              if (widget.existingSplits != null && widget.existingSplits!.isNotEmpty) {
                final split = widget.existingSplits!.where((s) => s.memberId == m.id.toString()).firstOrNull;
                _percentControllers[m.id.toString()] = TextEditingController(text: split?.percentage.toString() ?? '0');
                _exactControllers[m.id.toString()] = TextEditingController(text: split?.amount.toString() ?? '0');
              } else {
                _percentControllers[m.id.toString()] = TextEditingController(text: defaultPct);
                _exactControllers[m.id.toString()] = TextEditingController(text: '0');
              }
            }
          }
          
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Amount Input
                Text(
                  loc.translate('amount'),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                AppAmountInput(
                  controller: _amountController,
                  currencySymbol: currencySymbol,
                  autofocus: true,
                ),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Description & Category
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: AppInput(
                        controller: _descController,
                        hintText: loc.translate('what_for'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: _showCategoryPicker,
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHigh,
                            borderRadius: AppRadius.borderMd,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.receipt_long, color: Theme.of(context).colorScheme.primary, size: 24),
                              const SizedBox(height: 2),
                              Text(
                                loc.translate(_selectedCategory),
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary, overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Payer Selection
                Text(
                  loc.translate('payer'),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: members.map((member) => Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: _buildPayerChip(member.name, member.id.toString()),
                    )).toList(),
                  ),
                ),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Participants Selection
                Text(
                  loc.translate('participants') == 'participants' ? 'Katılımcılar' : loc.translate('participants'),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: members.map((member) => Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: _buildParticipantChip(member.name, member.id.toString()),
                    )).toList(),
                  ),
                ),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Split Type Toggle
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    borderRadius: AppRadius.borderLg,
                  ),
                  child: Row(
                    children: [
                      _buildSplitTypeTab(loc.translate('split_equal'), 'equal'),
                      _buildSplitTypeTab(loc.translate('split_percent'), 'percentage'),
                      _buildSplitTypeTab(loc.translate('amount_title'), 'exact'),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppSpacing.md),
                
                // Percentage or Exact Amount UI
                if (_splitType == 'percentage') _buildPercentageSplitUI(members),
                if (_splitType == 'exact') _buildExactAmountSplitUI(members),
                
                const SizedBox(height: AppSpacing.xl),
                
                // Submit Button
                PrimaryButton(
                  onPressed: () => _submitExpense(members),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(widget.existingExpense != null ? Icons.save : Icons.add_circle_outline, size: 20),
                      const SizedBox(width: AppSpacing.sm),
                      Text(widget.existingExpense != null ? loc.translate('edit') : loc.translate('new_expense')),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppSpacing.xl),
              ],
            );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Hata: $e')),
      ),
    );
  }

  void _showCategoryPicker() {
    AppBottomSheet.show(
      context: context,
      title: ref.read(localizationsProvider).translate('select_category'),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final loc = ref.read(localizationsProvider);
          return ListTile(
            title: Text(loc.translate(cat)),
            trailing: _selectedCategory == cat ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
            onTap: () {
              setState(() => _selectedCategory = cat);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  Widget _buildPayerChip(String name, String id) {
    final isSelected = _selectedPayerId == id;
    return GestureDetector(
      onTap: () => setState(() => _selectedPayerId = id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.surfaceContainerLowest,
          borderRadius: AppRadius.borderFull,
          border: Border.all(
            color: isSelected ? Colors.transparent : Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MemberAvatar(
              name: name,
              size: MemberAvatarSize.small,
              backgroundColor: isSelected ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.3) : Theme.of(context).colorScheme.surfaceContainerHighest,
              textColor: isSelected ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              name,
              style: TextStyle(
                color: isSelected ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantChip(String name, String id) {
    final isSelected = _selectedMembers.contains(id);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected && _selectedMembers.length > 1) { // Son kişinin tikini kaldırmayı engelle
            _selectedMembers.remove(id);
          } else if (!isSelected) {
            _selectedMembers.add(id);
          }
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              MemberAvatar(
                name: name,
                size: MemberAvatarSize.regular,
                backgroundColor: isSelected ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.surfaceContainerHighest,
                textColor: isSelected ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.onSurface,
                border: Border.all(
                  color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                  width: 3,
                ),
              ),
              if (isSelected)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Theme.of(context).colorScheme.surface, width: 2),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 64,
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSplitTypeTab(String label, String type) {
    final isSelected = _splitType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _splitType = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).colorScheme.surface : Colors.transparent,
            borderRadius: AppRadius.borderMd,
            boxShadow: isSelected ? AppShadows.light : null,
            border: isSelected ? Border.all(color: Theme.of(context).colorScheme.surfaceContainerHighest) : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPercentageSplitUI(List members) {
    final selectedMembersList = members.where((m) => _selectedMembers.contains(m.id.toString())).toList();
    if (selectedMembersList.isEmpty) return const SizedBox.shrink();

    double currentTotal = 0;
    for (final m in selectedMembersList) {
      currentTotal += double.tryParse(_percentControllers[m.id.toString()]?.text.replaceAll(',', '.') ?? '0') ?? 0.0;
    }
    
    final remaining = 100.0 - currentTotal;
    final isError = remaining.abs() > 0.015;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        border: Border.all(color: isError ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.surfaceContainerHighest),
        borderRadius: AppRadius.borderXl,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${ref.watch(localizationsProvider).translate('total')} %:', style: const TextStyle(fontWeight: FontWeight.bold)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('%${currentTotal.toStringAsFixed(1)}', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isError ? Theme.of(context).colorScheme.error : Colors.green,
                  )),
                  if (isError)
                    Text(
                      remaining > 0 ? '${ref.watch(localizationsProvider).translate('remaining')}: %${remaining.toStringAsFixed(2)}' : '${ref.watch(localizationsProvider).translate('excess')}: %${remaining.abs().toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: remaining > 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...selectedMembersList.map((m) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _buildPercentageRow(m.name, m.id.toString()),
          )),
          
          if (remaining > 0.015)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    final zeroMembers = selectedMembersList.where((m) {
                      final current = double.tryParse(_percentControllers[m.id.toString()]?.text.replaceAll(',', '.') ?? '0') ?? 0.0;
                      return current == 0.0;
                    }).toList();
                    
                    final membersToShare = zeroMembers.isNotEmpty ? zeroMembers : selectedMembersList;
                    final split = remaining / membersToShare.length;
                    
                    for (int i = 0; i < membersToShare.length; i++) {
                      final m = membersToShare[i];
                      final current = double.tryParse(_percentControllers[m.id.toString()]?.text.replaceAll(',', '.') ?? '0') ?? 0.0;
                      
                      _percentControllers[m.id.toString()]?.text = (current + split).toStringAsFixed(2);
                    }
                  });
                },
                icon: const Icon(Icons.calculate, size: 18),
                label: Text(ref.watch(localizationsProvider).translate('distribute_remaining')),
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExactAmountSplitUI(List members) {
    final selectedMembersList = members.where((m) => _selectedMembers.contains(m.id.toString())).toList();
    if (selectedMembersList.isEmpty) return const SizedBox.shrink();

    double currentTotal = 0;
    for (final m in selectedMembersList) {
      currentTotal += double.tryParse(_exactControllers[m.id.toString()]?.text.replaceAll(',', '.') ?? '0') ?? 0.0;
    }
    
    final targetTotal = double.tryParse(_amountController.text.replaceAll(',', '.')) ?? 0.0;
    final remaining = targetTotal - currentTotal;
    final isError = remaining.abs() > 0.015;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        border: Border.all(color: isError ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.surfaceContainerHighest),
        borderRadius: AppRadius.borderXl,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ref.watch(localizationsProvider).translate('total_amount_label'), style: const TextStyle(fontWeight: FontWeight.bold)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${currentTotal.toStringAsFixed(2)} / ${targetTotal.toStringAsFixed(2)}', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isError ? Theme.of(context).colorScheme.error : Colors.green,
                  )),
                  if (isError)
                    Text(
                      remaining > 0 ? '${ref.watch(localizationsProvider).translate('remaining_amount')} ${remaining.toStringAsFixed(2)} TL' : '${ref.watch(localizationsProvider).translate('excess_amount')} ${remaining.abs().toStringAsFixed(2)} TL', 
                      style: TextStyle(
                        fontSize: 12,
                        color: remaining > 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...selectedMembersList.map((m) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _buildExactAmountRow(m.name, m.id.toString()),
          )),
          
          if (remaining > 0.015)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    // Find people with 0 amount first
                    final zeroMembers = selectedMembersList.where((m) {
                      final current = double.tryParse(_exactControllers[m.id.toString()]?.text.replaceAll(',', '.') ?? '0') ?? 0.0;
                      return current == 0.0;
                    }).toList();
                    
                    // If some people have 0, share among them. Otherwise share among everyone.
                    final membersToShare = zeroMembers.isNotEmpty ? zeroMembers : selectedMembersList;
                    final split = remaining / membersToShare.length;
                    
                    for (int i = 0; i < membersToShare.length; i++) {
                      final m = membersToShare[i];
                      final current = double.tryParse(_exactControllers[m.id.toString()]?.text.replaceAll(',', '.') ?? '0') ?? 0.0;
                      
                      _exactControllers[m.id.toString()]?.text = (current + split).toStringAsFixed(2);
                    }
                  });
                },
                icon: const Icon(Icons.calculate, size: 18),
                label: Text(ref.watch(localizationsProvider).translate('distribute_remaining')),
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExactAmountRow(String name, String memberId) {
    return Row(
      children: [
        MemberAvatar(name: name, size: MemberAvatarSize.small),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(
          width: 130,
          child: AppInput(
            controller: _exactControllers[memberId],
            suffix: const Text('TL'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (v) => setState(() {}),
          ),
        ),
      ],
    );
  }

  Widget _buildPercentageRow(String name, String memberId) {
    return Row(
      children: [
        MemberAvatar(name: name, size: MemberAvatarSize.small),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SizedBox(
          width: 80,
          child: AppInput(
            controller: _percentControllers[memberId],
            suffix: const Text('%'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (v) => setState(() {}),
          ),
        ),
      ],
    );
  }

  Future<void> _submitExpense(List members) async {
    if (_selectedPayerId == null) return;
    
    final amountText = _amountController.text.replaceAll(',', '.');
    final amount = double.tryParse(amountText) ?? 0.0;
    
    if (amount <= 0) return;
    
    final isEditing = widget.existingExpense != null;
    
    final expense = ExpensesTableCompanion.insert(
      id: isEditing ? Value(widget.existingExpense!.id) : const Value.absent(),
      title: _descController.text.trim().isEmpty ? 'Harcama' : _descController.text.trim(),
      groupId: widget.groupId,
      payerId: _selectedPayerId!,
      amount: amount,
      description: Value(_descController.text.trim()),
      category: Value(_selectedCategory),
      splitType: Value(_splitType),
      createdAt: isEditing ? Value(widget.existingExpense!.createdAt) : Value(DateTime.now()),
    );
    
    final splits = <ExpenseSplitsTableCompanion>[];
    final selectedMembersList = members.where((m) => _selectedMembers.contains(m.id.toString())).toList();

    if (selectedMembersList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ref.read(localizationsProvider).translate('select_one_participant'))));
      return;
    }

    if (_splitType == 'equal') {
      final splitAmount = amount / selectedMembersList.length;
      for (final member in selectedMembersList) {
        splits.add(ExpenseSplitsTableCompanion(
          memberId: Value(member.id.toString()),
          amount: Value(splitAmount),
          percentage: Value(100.0 / selectedMembersList.length),
        ));
      }
    } else if (_splitType == 'percentage') {
      double totalPercent = 0;
      final memberPercentages = <String, double>{};
      
      for (final member in selectedMembersList) {
        final pct = double.tryParse(_percentControllers[member.id.toString()]?.text.replaceAll(',', '.') ?? '0') ?? 0.0;
        memberPercentages[member.id.toString()] = pct;
        totalPercent += pct;
      }
      
      if ((totalPercent - 100.0).abs() > 0.015) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ref.read(localizationsProvider).translate('split_percent_sum_error'))));
        return;
      }
      
      double allocatedAmount = 0;
      for (int i = 0; i < selectedMembersList.length; i++) {
        final member = selectedMembersList[i];
        final pct = memberPercentages[member.id.toString()]!;
        if (pct > 0) {
           double splitAmount = (amount * pct) / 100.0;
           
           if (i == selectedMembersList.length - 1) {
             splitAmount = amount - allocatedAmount;
           }
           
           splits.add(ExpenseSplitsTableCompanion(
             memberId: Value(member.id.toString()),
             amount: Value(splitAmount),
             percentage: Value(pct),
           ));
           allocatedAmount += splitAmount;
        }
      }
    } else if (_splitType == 'exact') {
      double totalExact = 0;
      final memberAmounts = <String, double>{};
      
      for (final member in selectedMembersList) {
        final amt = double.tryParse(_exactControllers[member.id.toString()]?.text.replaceAll(',', '.') ?? '0') ?? 0.0;
        memberAmounts[member.id.toString()] = amt;
        totalExact += amt;
      }
      
      if ((totalExact - amount).abs() > 0.015) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ref.read(localizationsProvider).translate('split_exact_sum_error'))));
        return;
      }
      
      double allocatedAmount = 0;
      for (int i = 0; i < selectedMembersList.length; i++) {
        final member = selectedMembersList[i];
        double amt = memberAmounts[member.id.toString()]!;
        
        if (i == selectedMembersList.length - 1) {
           amt = amount - allocatedAmount;
        }
        
        if (amt > 0) {
           splits.add(ExpenseSplitsTableCompanion(
             memberId: Value(member.id.toString()),
             amount: Value(amt),
             percentage: Value((amt / amount) * 100.0),
           ));
           allocatedAmount += amt;
        }
      }
    }
    
    if (isEditing) {
      await ref.read(expenseControllerProvider.notifier).updateExpenseWithSplits(
        expense: expense,
        splits: splits,
      );
    } else {
      await ref.read(expenseControllerProvider.notifier).addExpenseWithSplits(
        expense: expense,
        splits: splits,
      );
    }
    
    if (mounted) Navigator.pop(context);
  }
}
