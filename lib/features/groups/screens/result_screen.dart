import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/member_avatar.dart';
import '../../calculations/engine/debt_calculator.dart';
import '../../expenses/controllers/expense_controller.dart';
import '../controllers/member_controller.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/pdf_generator.dart';
import '../../../core/localization/app_localizations.dart';
import '../../expenses/screens/add_transfer_sheet.dart';
import '../../../shared/widgets/app_bottom_sheet.dart';
import '../../settings/controllers/settings_controller.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/formatters.dart';

class ResultScreen extends ConsumerWidget {
  final String groupId;

  const ResultScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupIdInt = int.tryParse(groupId) ?? 0;
    
    final membersAsync = ref.watch(groupMembersProvider(groupIdInt));
    final expensesAsync = ref.watch(groupExpensesProvider(groupIdInt));
    final splitsAsync = ref.watch(groupAllSplitsProvider(groupIdInt));
    
    // Determine loading/error state
    if (membersAsync.isLoading || expensesAsync.isLoading || splitsAsync.isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    
    if (membersAsync.hasError || expensesAsync.hasError || splitsAsync.hasError) {
      final loc = ref.read(localizationsProvider);
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        appBar: AppBar(title: Text(loc.translate('error'))),
        body: Center(child: Text(loc.translate('error_loading_data'))),
      );
    }

    final loc = ref.watch(localizationsProvider);
    final settings = ref.watch(settingsControllerProvider);
    final currency = Currency.fromCode(settings.currency) ?? Currency.tl;
    
    final members = membersAsync.value ?? [];
    final expenses = expensesAsync.value ?? [];
    final splits = splitsAsync.value ?? [];
    
    final totalExpense = expenses.fold(0.0, (sum, e) => sum + e.amount);
    
    // Calculate debts
    final calculator = ref.read(debtCalculatorProvider);
    final optimizedDebts = calculator.calculateMinimumTransfers(expenses, splits);
    
    // Helper to get member name
    String getMemberName(String id) {
      try {
        return members.firstWhere((m) => m.id.toString() == id).name;
      } catch (_) {
        return loc.translate('unknown');
      }
    }

    void shareResults() {
      final appName = loc.translate('app_name');
      if (optimizedDebts.isEmpty) {
        Share.share('$appName: ${loc.translate('share_msg_no_debt')}');
        return;
      }
      
      final StringBuffer sb = StringBuffer();
      sb.writeln('$appName ${loc.translate('share_msg_results')}');
      sb.writeln('--------------------');
      sb.writeln('${loc.translate('share_msg_total_expense')}: ${Formatters.currency(totalExpense, currency)}');
      sb.writeln('');
      sb.writeln(loc.translate('who_pays_who'));
      for (final debt in optimizedDebts) {
        final from = getMemberName(debt.fromMemberId);
        final to = getMemberName(debt.toMemberId);
        sb.writeln('• $from -> $to: ${Formatters.currency(debt.amount, currency)}');
      }
      
      Share.share(sb.toString());
    }

    Future<void> sharePdf() async {
      try {
        final appName = loc.translate('app_name');
        final path = await PdfGenerator.generateResultPdf(
          groupName: '${loc.translate('pdf_group')} $groupId',
          totalExpense: totalExpense,
          optimizedDebts: optimizedDebts,
          getMemberName: getMemberName,
          currencyCode: currency.code,
          loc: loc,
        );
        await Share.shareXFiles([XFile(path)], text: '$appName ${loc.translate('pdf_report')}');
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${loc.translate('pdf_generation_error')}: $e')));
        }
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: Text(loc.translate('close_account')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Toplam Harcama
            Center(
              child: Column(
                children: [
                  Text(
                    loc.translate('total_balance'),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                          letterSpacing: 1.5,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    Formatters.currency(totalExpense, currency),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppSpacing.xl),
            
            if (optimizedDebts.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Text('${loc.translate('share_msg_no_debt')} 🎉', textAlign: TextAlign.center),
                ),
              )
            else ...[
              Text(
                loc.translate('who_pays_who'),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              
              // Sonuç Kartları (Minimum transfer algorithm outputs)
              ...optimizedDebts.map((debt) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _buildTransferCard(
                  context,
                  loc: loc,
                  fromName: getMemberName(debt.fromMemberId),
                  toName: getMemberName(debt.toMemberId),
                  amount: Formatters.currency(debt.amount, currency),
                  onSettle: () {
                    AppBottomSheet.show(
                      context: context,
                      title: loc.translate('add_transfer'),
                      child: AddTransferSheet(
                        groupId: groupIdInt,
                        initialSenderId: debt.fromMemberId,
                        initialReceiverId: debt.toMemberId,
                        initialAmount: debt.amount,
                      ),
                    );
                  },
                ),
              )),
            ],
            
            const SizedBox(height: AppSpacing.xl * 2),
            
            // Export / Share Actions
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        onPressed: sharePdf,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.picture_as_pdf_outlined, size: 20),
                            SizedBox(width: AppSpacing.sm),
                            Text('PDF'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: SecondaryButton(
                        onPressed: shareResults,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.share_outlined, size: 20),
                            const SizedBox(width: AppSpacing.sm),
                            Text(loc.translate('share')),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryButton(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(loc.translate('clear_debts')),
                        content: Text(loc.translate('clear_data_confirm')),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(loc.translate('cancel')),
                          ),
                          FilledButton(
                            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(loc.translate('clear_debts')),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true && context.mounted) {
                      await ref.read(expenseControllerProvider.notifier).clearGroupDebts(groupIdInt);
                      if (context.mounted) {
                        context.pop();
                      }
                    }
                  },
                  child: Text(loc.translate('clear_debts')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransferCard(
    BuildContext context, {
    required AppLocalizations loc,
    required String fromName,
    required String toName,
    required String amount,
    required VoidCallback onSettle,
  }) {
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
          MemberAvatar(
            name: fromName,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
            textColor: Theme.of(context).colorScheme.onSurfaceVariant,
            size: MemberAvatarSize.small,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            fromName,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs / 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.1),
                    borderRadius: AppRadius.borderSm,
                  ),
                  child: Text(
                    amount,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                ),
                Icon(Icons.arrow_right, color: Theme.of(context).colorScheme.surfaceContainerHighest),
              ],
            ),
          ),
          
          Text(
            toName,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: AppSpacing.sm),
          MemberAvatar(
            name: toName,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            textColor: Theme.of(context).colorScheme.onPrimaryContainer,
            size: MemberAvatarSize.small,
          ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: onSettle,
              icon: const Icon(Icons.check_circle_outline, size: 18),
              label: Text(loc.translate('clear_debts')),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
