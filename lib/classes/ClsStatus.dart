import 'package:equatable/equatable.dart';

class ClsStatus extends Equatable {
  final int FreshCount;
  final double FreshLoans;
  final int OldCount;
  final double OldLoans;
  final double PrevFreshLoans;
  final double PrevOldLoans;
  final double Loans;
  final double Receipts;
  final double Redemptions;

  const ClsStatus({
    required this.FreshCount,
    required this.FreshLoans,
    required this.OldCount,
    required this.OldLoans,
    required this.PrevFreshLoans,
    required this.PrevOldLoans,
    required this.Loans,
    required this.Receipts,
    required this.Redemptions,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        FreshCount,
        FreshLoans,
        OldCount,
        OldLoans,
        PrevFreshLoans,
        PrevOldLoans,
        Loans,
        Receipts,
        Redemptions
      ];

  static ClsStatus fromJson(json) => ClsStatus(
        FreshCount: json['FreshCount'],
        FreshLoans: double.parse(json['FreshLoans']),
        OldCount: json['OldCount'],
        OldLoans: double.parse(json['OldLoans']),
        PrevFreshLoans: double.parse(json['PrevFreshLoans']),
        PrevOldLoans: double.parse(json['PrevOldLoans']),
        Loans: double.parse(json['Loans']),
        Receipts: double.parse(json['Receipts']),
        Redemptions: double.parse(json['Redemptions']),
      );
}
