import 'package:equatable/equatable.dart';

class ClsLoan extends Equatable {
  final int LoanSno;
  final String Loan_No;
  final DateTime Loan_Date;
  final String Party_Name;
  final String Mobile;
  final double Principal;

  const ClsLoan({
    required this.LoanSno,
    required this.Loan_No,
    required this.Loan_Date,
    required this.Party_Name,
    required this.Mobile,
    required this.Principal,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [LoanSno, Loan_No, Loan_Date, Party_Name, Mobile, Principal];

  static ClsLoan fromJson(json) => ClsLoan(
        LoanSno: json['LoanSno'],
        Loan_No: json['Loan_No'],
        Loan_Date: DateTime.parse(json['Loan_Date']['date']),
        Party_Name: json['Party_Name'],
        Mobile: json['Mobile'] == null ? "" : json['Mobile'],
        Principal: double.parse(json['Principal']),
      );
}
