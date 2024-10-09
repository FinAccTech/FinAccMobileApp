import 'package:equatable/equatable.dart';

class ClsRepledge extends Equatable {
  final int RepledgeSno;
  final String Repledge_No;
  final DateTime Repledge_Date;
  final String Ref_No;
  final String BankName;
  final double RpAmount;
  final int RpStatus;
  final String Loan_No;
  final double LnAmount;
  final DateTime Loan_Date;
  final String Party_Name;

  const ClsRepledge({
    required this.RepledgeSno,
    required this.Repledge_No,
    required this.Repledge_Date,
    required this.Ref_No,
    required this.BankName,
    required this.RpAmount,
    required this.RpStatus,
    required this.Loan_No,
    required this.LnAmount,
    required this.Loan_Date,
    required this.Party_Name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        RepledgeSno,
        Repledge_No,
        Repledge_Date,
        Ref_No,
        BankName,
        RpAmount,
        RpStatus,
        Loan_No,
        LnAmount,
        Loan_Date,
        Party_Name
      ];

  static ClsRepledge fromJson(json) => ClsRepledge(
        RepledgeSno: json['RePledgeSno'],
        Repledge_No: json['RePledge_No'],
        Repledge_Date: DateTime.parse(json['RePledge_Date']['date']),
        Ref_No: json['Ref_No'],
        BankName: json['BankName'],
        RpAmount: double.parse(json['RpAmount']),
        RpStatus: json['RpStatus'],
        Loan_No: json['Loan_No'],
        LnAmount: double.parse(json['LnAmount']),
        Loan_Date: DateTime.parse(json['Loan_Date']['date']),
        Party_Name: json['Party_Name'],
      );
}
