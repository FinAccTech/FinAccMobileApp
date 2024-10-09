import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClsAuctionList extends Equatable {
  final int LoanSno;
  final String Loan_No;
  final DateTime Loan_Date;
  final String Party_Name;
  final String Grp_Name;
  final String Mobile;
  final String Area_Name;
  final double Principal;
  final double Market_Value;
  final DateTime Mature_Date;
  final String Items;
  final double TotGrossWt;
  final double TotNettWt;
  final int Reminders_Sent;

  const ClsAuctionList(
      {required this.LoanSno,
      required this.Loan_No,
      required this.Loan_Date,
      required this.Party_Name,
      required this.Grp_Name,
      required this.Mobile,
      required this.Area_Name,
      required this.Principal,
      required this.Market_Value,
      required this.Mature_Date,
      required this.Items,
      required this.TotGrossWt,
      required this.TotNettWt,
      required this.Reminders_Sent});

  @override
  // TODO: implement props
  List<Object?> get props => [
        LoanSno,
        Loan_No,
        Loan_Date,
        Party_Name,
        Grp_Name,
        Mobile,
        Area_Name,
        Principal,
        Market_Value,
        Mature_Date,
        Items,
        TotGrossWt,
        TotNettWt,
        Reminders_Sent
      ];

  static ClsAuctionList fromJson(json) => ClsAuctionList(
        LoanSno: json['LoanSno'],
        Loan_No: json['Loan_No'],
        Loan_Date: DateTime.parse(json['Loan_Date']['date']),
        Party_Name: json['Party_Name'],
        Grp_Name: json['Grp_Name'],
        Mobile: json['Mobile'],
        Area_Name: json['Area_Name'],
        Principal: double.parse(json['Principal']),
        Market_Value: double.parse(json['MarketValue']),
        Mature_Date: DateTime.parse(json['Mature_Date']['date']),
        Items: json['Items'],
        TotGrossWt: double.parse(json['TotGrossWt']),
        TotNettWt: double.parse(json['TotNettWt']),
        Reminders_Sent:
            json['Reminders_Sent'] == null ? 0 : json['Reminders_Sent'],
      );
}
