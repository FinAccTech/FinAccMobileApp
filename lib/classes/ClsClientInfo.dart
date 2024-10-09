import 'package:equatable/equatable.dart';

class ClsClientInfo extends Equatable {
  final int ClientSno;
  final String Client_Code;
  final String Client_Name;
  final String Mobile;
  final String Email;
  final String Contact_Person;
  final bool WebEnabled;
  final bool Status;

  const ClsClientInfo({
    required this.ClientSno,
    required this.Client_Code,
    required this.Client_Name,
    required this.Mobile,
    required this.Email,
    required this.Contact_Person,
    required this.WebEnabled,
    required this.Status,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        ClientSno,
        Client_Code,
        Client_Name,
        Mobile,
        Email,
        Contact_Person,
        WebEnabled,
        Status
      ];

  static ClsClientInfo fromJson(json) => ClsClientInfo(
        ClientSno: json['ClientSno'],
        Client_Code: json['Client_Code'],
        Client_Name: json['Client_Name'],
        Mobile: json['Mobile'] == null ? "" : json['Mobile'],
        Email: json['Email'] == null ? "" : json['Email'],
        Contact_Person:
            json['Contact_Person'] == null ? "" : json['Contact_Person'],
        // Installtion_Date: DateTime.parse(json['Installation_Date']['date']),
        // Warranty_Expiry_Date: DateTime.parse(json['Warranty_Expiry_Date']['date']),
        // AMC_Expiry_Date: DateTime.parse(json['AMC_Expiry_Date']['date']),
        // App_Expiry_Date: DateTime.parse(json['App_Expiry_Date']['date']),
        WebEnabled: json['WebEnabled'] == null
            ? false
            : json['WebEnabled'] == 0
                ? false
                : true,
        Status: json['Status'] == null
            ? false
            : json['Status'] == 0
                ? false
                : true,
      );
}
