import 'package:equatable/equatable.dart';

class ClsReceipts extends Equatable {
  final int RecSno;
  final String Rec_No;
  final DateTime RecDate;
  final int Rec_Type;
  final double IntAmt;
  final double Principal_Amt;
  final double Nett_Amt;
  final String Loan_No;
  final String Party_Name;

  const ClsReceipts(
      {required this.RecSno,
      required this.Rec_No,
      required this.RecDate,
      required this.Rec_Type,
      required this.IntAmt,
      required this.Principal_Amt,
      required this.Nett_Amt,
      required this.Loan_No,
      required this.Party_Name});

  @override
  // TODO: implement props
  List<Object?> get props => [
        RecSno,
        Rec_No,
        RecDate,
        Rec_Type,
        IntAmt,
        Principal_Amt,
        Nett_Amt,
        Loan_No,
        Party_Name
      ];

  static ClsReceipts fromJson(json) => ClsReceipts(
        RecSno: json['RecSno'],
        Rec_No: json['Rec_No'],
        RecDate: DateTime.parse(json['RecDate']['date']),
        Rec_Type: json['Rec_Type'],
        IntAmt: double.parse(json['IntAmt']),
        Principal_Amt: double.parse(json['Principal_Amt']),
        Nett_Amt: double.parse(json['Nett_Amt']),
        Loan_No: json['Loan_No'],
        Party_Name: json['Party_Name'],
      );
}
