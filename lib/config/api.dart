import 'dart:convert';
import 'dart:io';
import 'package:finacc/classes/ClsAuctionList.dart';
import 'package:finacc/classes/ClsClientInfo.dart';
import 'package:finacc/classes/ClsCustomerHistory.dart';
import 'package:finacc/classes/ClsDaybook.dart';
import 'package:finacc/classes/ClsLoan.dart';
import 'package:finacc/classes/ClsLoanSummary.dart';

import 'package:finacc/classes/ClsParty.dart';
import 'package:finacc/classes/ClsReceipts.dart';
import 'package:finacc/classes/ClsRepledge.dart';
import 'package:finacc/classes/ClsStatus.dart';
import 'package:finacc/classes/ClsTransactions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'globals.dart' as Globals;

final headers = {
  HttpHeaders.contentTypeHeader:
      'application/x-www-form-urlencoded; charset=UTF-8'
};

class Api {
  static Future<bool> getUser(
      String User_Name, String User_Password, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    final queryParameters = {
      'data':
          '{"DbName" : "", "User_Name" : "$User_Name", "User_Password" : "$User_Password"}',
    };
    final uri = Uri.https(
        Globals.HttpServer, Globals.BaseUrl + 'rep/getUser', queryParameters);
    print(uri);

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();

    if (body['queryStatus'] == 0) {
      return false;
    } else {
      Globals.IsLoggedIn = true;
      Globals.LoggedUser = User_Name;
      Globals.LoggedPwd = User_Password;
      Globals.Comp_Name = body['apiData'][0]['Comp_Name'];
      Globals.DbName = body['apiData'][0]['DbName'];

      Globals.ClientInfo = body['ClientInfo']
          .map<ClsClientInfo>(ClsClientInfo.fromJson)
          .toList();
      return true;
    }
  }

  static Future<List> getCompanies(BuildContext context) async {
    OverlayLoadingProgress.start(context);
    String ClientCode = Globals.ClientInfo[0].Client_Code;
    final queryParameters = {
      'data': '{"ClientCode" : "$ClientCode", "DbName" : ""}',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getCompaniesList', queryParameters);

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].toList();
  }

  static Future<List<ClsStatus>> getStatusCard(
      int StatusType, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"StatusType" : "$StatusType", "DbName" : "$DbName" }',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getStatusCard', queryParameters);

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsStatus>(ClsStatus.fromJson).toList();
  }

  static Future<bool> getLatestVersion(BuildContext context) async {
    OverlayLoadingProgress.start(context);
    final queryParameters = {
      'data': '{"DbName" : ""}',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getLatestVersion', queryParameters);

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();

    if (body['queryStatus'] == 0) {
      return false;
    } else {
      Globals.AppLatestVer = body['apiData'][0]['Current_Version'];
      Globals.AllowOldversion =
          body['apiData'][0]['Allow_OldVersion'] == 0 ? false : true;
      return true;
    }
  }

  static Future<List<ClsTransactions>> getRecentTransactions(
      BuildContext context) async {
    //OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName" }',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getRecentTransactions', queryParameters);

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    //OverlayLoadingProgress.stop();
    return body['apiData']
        .map<ClsTransactions>(ClsTransactions.fromJson)
        .toList();
  }

  static Future<List> getDayBook(DateTime tDate, BuildContext context) async {
    tDate = DateUtils.dateOnly(tDate);

    OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "Date" : "$tDate" }',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getDayBook', queryParameters);

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return [
      body['apiData'].map<ClsDayBook>(ClsDayBook.fromJson).toList(),
      body['OpenBal'],
      body['CloseBal']
    ];
  }

  static Future<List<ClsAuctionList>> getAuctionHistory(
      DateTime AsOn, BuildContext context) async {
    AsOn = DateUtils.dateOnly(AsOn);

    //OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "AsOn" : "$AsOn" }',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getAuctionHistory', queryParameters);

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    //OverlayLoadingProgress.stop();
    return body['apiData']
        .map<ClsAuctionList>(ClsAuctionList.fromJson)
        .toList();
  }

  static Future<List<ClsParty>> getPartyList(
      int PageNumber, int RecordCount, BuildContext context) async {
    OverlayLoadingProgress.start(context);

    String DbName = Globals.DbName;
    final queryParameters = {
      'data':
          '{"DbName" : "$DbName", "PageNumber" : "$PageNumber", "RecordCount" : "$RecordCount" }',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getPartyList', queryParameters);

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsParty>(ClsParty.fromJson).toList();
  }

  // static Future<List<ClsParty>> getPartyList( int PageNumber, int RecordCount, BuildContext context) async {
  //   OverlayLoadingProgress.start(context);
  //
  //   String DbName = Globals.DbName;
  //   final queryParameters =  {"userName" : "SCRMWS", "password" : "abc123"   };
  //   final uri = Uri.http(
  //       'scrmuat.icicibank.com', '/restapi/oauth2/token',
  //       queryParameters);
  //
  //
  //   final response = await http.get(uri, headers: headers);
  //   final body = json.decode(response.body);
  //   print (body);
  //   OverlayLoadingProgress.stop();
  //   return body['apiData'].map<ClsParty>(ClsParty.fromJson).toList();
  // }
  static Future<void> sendData() async {
    final response = await http.post(
      Uri.parse('https://scrmuat.icicibank.com/restapi/oauth2/token'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'userName': 'SCRMWS',
        'password': 'abc123',
      }),
    );

    if (response.statusCode == 201) {
      // Successful response
      print('Response data: ${response.body}');
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  static Future<List<ClsParty>> getFilteredPartyList(
      String FltrQry, BuildContext context) async {
    OverlayLoadingProgress.start(context);

    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "FltrQry" : "$FltrQry" }',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getFilteredPartyList', queryParameters);

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsParty>(ClsParty.fromJson).toList();
  }

  static Future<List<ClsLoan>> getLoansList(int LnStatus, int PageNumber,
      int RecordCount, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data':
          '{"DbName" : "$DbName", "LnStatus" : "$LnStatus", "PageNumber" : "$PageNumber", "RecordCount" : "$RecordCount" }',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getLoansList', queryParameters);

    // final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    // headers['Connection'] = "keep-alive";

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsLoan>(ClsLoan.fromJson).toList();
  }

  static Future<List<ClsLoan>> getFilteredLoansList(
      int LnStatus, String FltrQry, BuildContext context) async {
    OverlayLoadingProgress.start(context);

    String DbName = Globals.DbName;
    final queryParameters = {
      'data':
          '{"DbName" : "$DbName","LnStatus" : "$LnStatus", "FltrQry" : "$FltrQry" }',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getFilteredLoansList', queryParameters);

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsLoan>(ClsLoan.fromJson).toList();
  }

  static Future<List<ClsCustomerHistory>> getCustomerHistory(
      int PartySno, BuildContext context) async {
    //OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "PartySno" : "$PartySno" }',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getCustomerHistory', queryParameters);

    print(uri);

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    //OverlayLoadingProgress.stop();
    print(body);
    return body['apiData']
        .map<ClsCustomerHistory>(ClsCustomerHistory.fromJson)
        .toList();
  }

  static Future<List> getLoanSummary(int LoanSno, BuildContext context) async {
    //OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "LoanSno" : "$LoanSno" }',
    };

    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getLoanSummary', queryParameters);

    final response = await http.get(uri, headers: headers);

    final body = json.decode(response.body);

    //OverlayLoadingProgress.stop();
    return [
      body['apiData'].map<ClsLoanSummary>(ClsLoanSummary.fromJson).toList(),
      body['LoanTrans'].toList()
    ];
  }

  static Future<List<ClsRepledge>> getRepledgeList(
      int PageNumber, int RecordCount, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data':
          '{"DbName" : "$DbName", "PageNumber" : "$PageNumber", "RecordCount" : "$RecordCount" }',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getRepledgeList', queryParameters);

    headers['Connection'] = "keep-alive";

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsRepledge>(ClsRepledge.fromJson).toList();
  }

  static Future<List<ClsRepledge>> getFilteredRepledgeList(
      String FltrQry, BuildContext context) async {
    OverlayLoadingProgress.start(context);

    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "FltrQry" : "$FltrQry" }',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getFilteredRepledgeList', queryParameters);

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsRepledge>(ClsRepledge.fromJson).toList();
  }

  static Future<List<ClsReceipts>> getReceiptsList(
      int PageNumber, int RecordCount, BuildContext context) async {
    OverlayLoadingProgress.start(context);
    String DbName = Globals.DbName;
    final queryParameters = {
      'data':
          '{"DbName" : "$DbName", "PageNumber" : "$PageNumber", "RecordCount" : "$RecordCount" }',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getReceiptsList', queryParameters);

    headers['Connection'] = "keep-alive";

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsReceipts>(ClsReceipts.fromJson).toList();
  }

  static Future<List<ClsReceipts>> getFilteredReceiptsList(
      String FltrQry, BuildContext context) async {
    OverlayLoadingProgress.start(context);

    String DbName = Globals.DbName;
    final queryParameters = {
      'data': '{"DbName" : "$DbName", "FltrQry" : "$FltrQry" }',
    };
    final uri = Uri.https(Globals.HttpServer,
        Globals.BaseUrl + 'rep/getFilteredReceiptsList', queryParameters);

    final response = await http.get(uri, headers: headers);
    final body = json.decode(response.body);
    OverlayLoadingProgress.stop();
    return body['apiData'].map<ClsReceipts>(ClsReceipts.fromJson).toList();
  }
}
