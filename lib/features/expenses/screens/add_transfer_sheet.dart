import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column, Row;
import '../../../core/localization/app_localizations.dart';
import '../../settings/controllers/settings_controller.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_input.dart';
import '../../../shared/widgets/member_avatar.dart';
import '../../groups/controllers/member_controller.dart';
import '../controllers/expense_controller.dart';
import '../../../../services/database/app_database.dart';
import 'package:go_router/go_router.dart';

class AddTransferSheet extends ConsumerStatefulWidget {
  final int groupId;
  final Expense? existingExpense;
  final List<ExpenseSplit>? existingSplits;
  final String? initialSenderId;
  final String? initialReceiverId;
  final double? initialAmount;

  const AddTransferSheet({
    super.key,
    required this.groupId,
    this.existingExpense,
    this.existingSplits,
    this.initialSenderId,
    this.initialReceiverId,
    this.initialAmount,
  });

  @override
  ConsumerState<AddTransferSheet> createState() => _AddTransferSheetState();
}

class _AddTransferSheetState extends ConsumerState<AddTransferSheet> {
  final _amountController = TextEditingController();
  final _descController = TextEditingController();
  
  String? _selectedSenderId;
  String? _selectedReceiverId;

  @override
  void initState() {
    super.initState();
    if (widget.existingExpense != null) {
      _amountController.text = widget.existingExpense!.amount.toString();
      _descController.text = widget.existingExpense!.description ?? '';
      _selectedSenderId = widget.existingExpense!.payerId;
      
      if (widget.existingSplits != null && widget.existingSplits!.isNotEmpty) {
        _selectedReceiverId = widget.existingSplits!.first.memberId;
      }
    } else {
      if (widget.initialSenderId != null) {
        _selectedSenderId = widget.initialSenderId;
      }
      if (widget.initialReceiverId != null) {
        _selectedReceiverId = widget.initialReceiverId;
      }
      if (widget.initialAmount != null) {
        _amountController.text = widget.initialAmount!.toStringAsFixed(2);
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final membersAsync = ref.watch(groupMembersProvider(widget.groupId));
    final loc = ref.watch(localizationsProvider);
    final settings = ref.watch(settingsControllerProvider);
    final currencySymbol = Currency.fromCode(settings.currency)?.symbol ?? '₺';

    return membersAsync.when(
      data: (members) {
        if (members.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
            child: Text(loc.translate('transfer_no_member')),
          );
        }

        _selectedSenderId ??= widget.existingExpense?.payerId ?? members.first.id.toString();
        
        // Setup default receiver to someone else
        if (_selectedReceiverId == null && members.length > 1) {
          _selectedReceiverId = members.firstWhere((m) => m.id.toString() != _selectedSenderId).id.toString();
        } else if (_selectedReceiverId == null) {
           _selectedReceiverId = members.first.id.toString();
        }

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sender Selection
              Text(
                loc.translate('transfer_sender'),
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
                    child: _buildMemberChip(member.name, member.id.toString(), true),
                  )).toList(),
                ),
              ),
              
              const SizedBox(height: AppSpacing.md),
              
              const Center(
                child: Icon(Icons.arrow_downward, color: Colors.grey),
              ),
              
              const SizedBox(height: AppSpacing.md),

              // Receiver Selection
              Text(
                loc.translate('transfer_receiver'),
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
                    child: _buildMemberChip(member.name, member.id.toString(), false),
                  )).toList(),
                ),
              ),
              
              const SizedBox(height: AppSpacing.lg),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: AppInput(
                      controller: _amountController,
                      label: loc.translate('amount'),
                      prefix: Text('$currencySymbol ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      autofocus: true,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    flex: 3,
                    child: AppInput(
                      controller: _descController,
                      label: loc.translate('description'),
                      hintText: loc.translate('transfer_desc_hint'),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppSpacing.xl),
              
              FilledButton.icon(
                onPressed: () => _submitTransfer(members),
                icon: const Icon(Icons.sync_alt),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.borderLg),
                ),
                label: Text(
                  widget.existingExpense == null ? loc.translate('transfer_save') : loc.translate('transfer_edit'),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        );
      },
      loading: () => const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator())),
      error: (err, stack) => Padding(
        padding: const EdgeInsets.all(32),
        child: Text('Hata: $err'),
      ),
    );
  }

  Widget _buildMemberChip(String name, String id, bool isSender) {
    final isSelected = isSender ? _selectedSenderId == id : _selectedReceiverId == id;
    
    // Disable selecting same person for sender and receiver
    final isDisabled = isSender ? _selectedReceiverId == id : _selectedSenderId == id;
    
    return GestureDetector(
      onTap: isDisabled ? null : () {
        setState(() {
          if (isSender) {
            _selectedSenderId = id;
          } else {
            _selectedReceiverId = id;
          }
        });
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isDisabled ? 0.3 : 1.0,
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
      ),
    );
  }

  Future<void> _submitTransfer(List members) async {
    if (_selectedSenderId == null || _selectedReceiverId == null) return;
    
    final amountText = _amountController.text.replaceAll(',', '.');
    final amount = double.tryParse(amountText) ?? 0.0;
    
    if (amount <= 0) {
      final loc = ref.read(localizationsProvider);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loc.translate('transfer_invalid_amount'))));
      return;
    }
    
    final isEditing = widget.existingExpense != null;
    
    final expense = ExpensesTableCompanion.insert(
      id: isEditing ? Value(widget.existingExpense!.id) : const Value.absent(),
      title: _descController.text.trim().isEmpty ? 'Borç / Transfer' : _descController.text.trim(),
      groupId: widget.groupId,
      payerId: _selectedSenderId!,
      amount: amount,
      description: Value(_descController.text.trim()),
      category: const Value('category_transfer'),
      splitType: const Value('exact'),
      createdAt: isEditing ? Value(widget.existingExpense!.createdAt) : Value(DateTime.now()),
    );
    
    final splits = <ExpenseSplitsTableCompanion>[];
    
    // The receiver owes 100% of this transfer amount to the sender
    splits.add(ExpenseSplitsTableCompanion(
      memberId: Value(_selectedReceiverId!),
      amount: Value(amount),
      percentage: const Value(100.0),
    ));
    
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
    
    if (mounted) {
      context.pop();
    }
  }
}
