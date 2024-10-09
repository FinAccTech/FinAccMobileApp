import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClsLoanSummary extends Equatable {
  final int LoanSno;
  final String Party_Code;
  final String Party_Name;
  final String Area_Name;
  final String Mobile;
  final DateTime Loan_Date;
  final String Loan_No;
  final String Location_Name;
  final String Grp_Name;
  final String IntTypeName;
  final double Principal;
  final double Principal_Balance;
  final double Interest_Balance;
  final double AdvInt_Amount;
  final DateTime IntPaid_Upto;
  final DateTime Mature_Date;
  final int Dur_Months;
  final int Dur_Days;
  final double NettAmt_Balance;
  final double TotGrossWt;
  final double TotNettWt;
  final int Status;
  final int RepStatus;

  const ClsLoanSummary({
    required this.LoanSno,
    required this.Party_Code,
    required this.Party_Name,
    required this.Area_Name,
    required this.Mobile,
    required this.Loan_Date,
    required this.Loan_No,
    required this.Location_Name,
    required this.Grp_Name,
    required this.IntTypeName,
    required this.Principal,
    required this.Principal_Balance,
    required this.Interest_Balance,
    required this.AdvInt_Amount,
    required this.IntPaid_Upto,
    required this.Mature_Date,
    required this.Dur_Months,
    required this.Dur_Days,
    required this.NettAmt_Balance,
    required this.TotGrossWt,
    required this.TotNettWt,
    required this.Status,
    required this.RepStatus,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        LoanSno,
        Party_Code,
        Party_Name,
        Area_Name,
        Mobile,
        Loan_Date,
        Loan_No,
        Location_Name,
        Grp_Name,
        IntTypeName,
        Principal,
        Principal_Balance,
        Interest_Balance,
        AdvInt_Amount,
        IntPaid_Upto,
        Mature_Date,
        Dur_Months,
        Dur_Days,
        NettAmt_Balance,
        TotGrossWt,
        TotNettWt,
        Status,
        RepStatus,
      ];

  static ClsLoanSummary fromJson(json) => ClsLoanSummary(
        LoanSno: json['LoanSno'],
        Party_Code: json['Party_Code'],
        Party_Name: json['Party_Name'],
        Area_Name: json['Area_Name'],
        Mobile: json['Mobile'],
        Loan_Date: DateTime.parse(json['Loan_Date']['date']),
        Loan_No: json['Loan_No'],
        Location_Name: json['Location_Name'],
        Grp_Name: json['Grp_Name'],
        IntTypeName: json['IntTypeName'],
        Principal: double.parse(json['LoanAmt']),
        Principal_Balance: double.parse(json['Principal_Balance']),
        Interest_Balance: double.parse(json['Interest_Balance']),
        AdvInt_Amount: double.parse(json['AdvInt_Amount']),
        IntPaid_Upto: DateTime.parse(json['IntPaid_Upto']['date']),
        Mature_Date: DateTime.parse(json['Mature_Date']['date']),
        Dur_Months: json['Dur_Months'],
        Dur_Days: json['Dur_Days'],
        NettAmt_Balance: double.parse(json['NettAmt_Balance']),
        TotGrossWt: double.parse(json['TotGrossWt']),
        TotNettWt: double.parse(json['TotNettWt']),
        Status: json['Status'],
        RepStatus: json['RepStatus'],
      );
}
