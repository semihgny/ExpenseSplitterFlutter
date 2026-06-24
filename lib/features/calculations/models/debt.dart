class Debt {
  final String fromMemberId;
  final String toMemberId;
  final double amount;

  const Debt({
    required this.fromMemberId,
    required this.toMemberId,
    required this.amount,
  });

  @override
  String toString() => 'Debt(from: $fromMemberId, to: $toMemberId, amount: $amount)';
}
