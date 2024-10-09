import 'package:equatable/equatable.dart';

class ClsParty extends Equatable {
  final int PartySno;
  final String Party_Code;
  final String Party_Name;
  final int Party_Cat;
  final int Rel;
  final String RelName;
  final String Mobile;
  final int VerifyStatus;
  final String Address1;
  final String Address2;
  final String Address3;
  final String Address4;
  final String City;
  final String Area_Name;

  const ClsParty({
    required this.PartySno,
    required this.Party_Code,
    required this.Party_Name,
    required this.Party_Cat,
    required this.Rel,
    required this.RelName,
    required this.Mobile,
    required this.VerifyStatus,
    required this.Address1,
    required this.Address2,
    required this.Address3,
    required this.Address4,
    required this.City,
    required this.Area_Name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        PartySno,
        Party_Code,
        Party_Name,
        Party_Cat,
        Rel,
        RelName,
        Mobile,
        VerifyStatus,
        Address1,
        Address2,
        Address3,
        Address4,
        City,
        Area_Name
      ];

  static ClsParty fromJson(json) => ClsParty(
        PartySno: json['PartySno'],
        Party_Code: json['Party_Code'].toString(),
        Party_Name: json['Party_Name'],
        Party_Cat: json['Party_Cat'],
        Rel: json['Rel'],
        RelName: json['RelName'],
        Mobile: json['Mobile'],
        VerifyStatus: json['VerifyStatus'],
        Address1: json['Address1'],
        Address2: json['Address2'],
        Address3: json['Address3'],
        Address4: json['Address4'],
        City: json['City'],
        Area_Name: json['Area_Name'],
      );
}
