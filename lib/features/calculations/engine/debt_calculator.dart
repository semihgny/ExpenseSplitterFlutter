import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/database/app_database.dart';
import '../models/debt.dart';

final debtCalculatorProvider = Provider<DebtCalculator>((ref) {
  return DebtCalculator();
});

class DebtCalculator {
  /// Computes the optimized debts (minimum transfers) from a list of expenses and splits.
  List<Debt> calculateMinimumTransfers(List<Expense> expenses, List<ExpenseSplit> splits) {
    // 1. Calculate net balances for each member
    // positive balance = member is owed money (they paid more than their share)
    // negative balance = member owes money (their share is more than they paid)
    final balances = <String, double>{};

    for (final expense in expenses) {
      // The payer's balance increases by the total amount they paid
      balances[expense.payerId] = (balances[expense.payerId] ?? 0) + expense.amount;
    }

    for (final split in splits) {
      // The split member's balance decreases by their share amount
      balances[split.memberId] = (balances[split.memberId] ?? 0) - split.amount;
    }

    // 2. Separate into debtors and creditors
    final debtors = <String, double>{};
    final creditors = <String, double>{};

    balances.forEach((memberId, balance) {
      // Rounding to 2 decimal places to avoid floating point precision issues
      final roundedBalance = (balance * 100).round() / 100;
      if (roundedBalance > 0.01) {
        creditors[memberId] = roundedBalance;
      } else if (roundedBalance < -0.01) {
        debtors[memberId] = -roundedBalance; // Store as positive debt amount
      }
    });

    // 3. Greedily match debtors to creditors
    final optimizedDebts = <Debt>[];

    final debtorEntries = debtors.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final creditorEntries = creditors.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    int d = 0; // Debtor index
    int c = 0; // Creditor index

    while (d < debtorEntries.length && c < creditorEntries.length) {
      final debtorId = debtorEntries[d].key;
      final debtorAmount = debtorEntries[d].value;
      
      final creditorId = creditorEntries[c].key;
      final creditorAmount = creditorEntries[c].value;

      final transferAmount = min(debtorAmount, creditorAmount);
      
      if (transferAmount > 0) {
        optimizedDebts.add(Debt(
          fromMemberId: debtorId,
          toMemberId: creditorId,
          amount: transferAmount,
        ));
      }

      debtorEntries[d] = MapEntry(debtorId, debtorAmount - transferAmount);
      creditorEntries[c] = MapEntry(creditorId, creditorAmount - transferAmount);

      if (debtorEntries[d].value < 0.01) d++;
      if (creditorEntries[c].value < 0.01) c++;
    }

    return optimizedDebts;
  }
}
