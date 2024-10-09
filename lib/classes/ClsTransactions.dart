import 'package:equatable/equatable.dart';

class ClsTransactions extends Equatable {
  final String TransDate;
  final String TransNo;
  final String Party;
  final String TransType;
  final double Amount;
  final String IGrp;

  const ClsTransactions({
    required this.TransDate,
    required this.TransNo,
    required this.Party,
    required this.TransType,
    required this.Amount,
    required this.IGrp,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [TransDate, TransNo, Party, TransType, Amount, IGrp];

  static ClsTransactions fromJson(json) => ClsTransactions(
        TransDate: json['TransDate'],
        TransNo: json['TransNo'],
        Party: json['Party'],
        TransType: json['TransType'],
        Amount: double.parse(json['Amount']),
        IGrp: json['IGrp'],
      );
}
