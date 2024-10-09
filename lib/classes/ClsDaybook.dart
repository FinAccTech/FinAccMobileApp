import 'package:equatable/equatable.dart';

class ClsDayBook extends Equatable {
  final String VouType_Name;
  final String Vou_No;
  final int LedSno;
  final int GrpSno;
  final String Grp_Name;
  final String Led_Name;
  final double Credit;
  final double Debit;
  final String Narration;

  const ClsDayBook({
    required this.VouType_Name,
    required this.Vou_No,
    required this.LedSno,
    required this.GrpSno,
    required this.Grp_Name,
    required this.Led_Name,
    required this.Credit,
    required this.Debit,
    required this.Narration,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        VouType_Name,
        Vou_No,
        LedSno,
        GrpSno,
        Grp_Name,
        Led_Name,
        Credit,
        Debit,
        Narration
      ];

  static ClsDayBook fromJson(json) => ClsDayBook(
        VouType_Name: json['VouType_Name'],
        Vou_No: json['Vou_No'],
        LedSno: json['LedSno'],
        GrpSno: json['GrpSno'],
        Grp_Name: json['Grp_Name'],
        Led_Name: json['Led_Name'],
        Credit: double.parse(json['Credit']),
        Debit: double.parse(json['Debit']),
        Narration: json['Narration'],
      );
}
