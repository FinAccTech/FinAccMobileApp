import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClsCustomerHistory extends Equatable {
  final int LoanSno;
  final String Loan_No;
  final DateTime Loan_Date;
  final double Principal;
  final double AdvInt_Amount;
  final double NettAmt;
  final double TotGrossWt;
  final double TotNettWt;
  final int Dur_Months;
  final int Dur_Days;
  final String ItemDetails;
  final int Status;
  final int TotalLoans;
  final int LiveLoans;
  final int Terminated;
  final int ReadyforAuction;
  final int Auctioned;
  final String Red_Date;

  const ClsCustomerHistory({
    required this.LoanSno,
    required this.Loan_No,
    required this.Loan_Date,
    required this.Principal,
    required this.AdvInt_Amount,
    required this.NettAmt,
    required this.TotGrossWt,
    required this.TotNettWt,
    required this.Dur_Months,
    required this.Dur_Days,
    required this.ItemDetails,
    required this.Status,
    required this.TotalLoans,
    required this.LiveLoans,
    required this.Terminated,
    required this.ReadyforAuction,
    required this.Auctioned,
    required this.Red_Date,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        LoanSno,
        Loan_No,
        Loan_Date,
        Principal,
        AdvInt_Amount,
        NettAmt,
        TotGrossWt,
        TotNettWt,
        Dur_Months,
        Dur_Days,
        ItemDetails,
        Status,
        TotalLoans,
        LiveLoans,
        Terminated,
        ReadyforAuction,
        Auctioned,
        Red_Date
      ];

  static ClsCustomerHistory fromJson(json) => ClsCustomerHistory(
        LoanSno: json['LoanSno'],
        Loan_No: json['Loan_No'],
        Loan_Date: DateTime.parse(json['Loan_Date']['date']),
        Principal: double.parse(json['Principal']),
        AdvInt_Amount: json['AdvInt_Amount'] == null
            ? 0
            : double.parse(json['AdvInt_Amount']),
        NettAmt: double.parse(json['NettAmt']),
        TotGrossWt: double.parse(json['TotGrossWt']),
        TotNettWt: double.parse(json['TotNettWt']),
        Dur_Months: json['Dur_Months'] == null ? 0 : json['Dur_Months'],
        Dur_Days: json['Dur_Days'] == null ? 0 : json['Dur_Days'],
        ItemDetails: json['ItemDetails'] == null ? "" : json['ItemDetails'],
        Status: json['Status'],
        TotalLoans: json['TotalLoans'] == null ? 0 : json['TotalLoans'],
        LiveLoans: json['LiveLoans'] == null ? 0 : json['LiveLoans'],
        Terminated: json['Terminated'] == null ? 0 : json['Terminated'],
        ReadyforAuction:
            json['ReadyforAuction'] == null ? 0 : json['ReadyforAuction'],
        Auctioned: json['Auctioned'] == null ? 0 : json['Auctioned'],
        Red_Date: json['Red_Date'] == null
            ? ""
            : DateFormat('dd-MM-yyyy')
                .format(DateTime.parse(json['Red_Date']['date']))
                .toString(),
      );
}
