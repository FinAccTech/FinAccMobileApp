import 'package:finacc/classes/ClsCustomerHistory.dart';
import 'package:finacc/classes/ClsParty.dart';
import 'package:finacc/config/api.dart';
import 'package:finacc/config/globals.dart';
import 'package:finacc/screens/loansummary.dart';
import 'package:finacc/widgets/fadetransition.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerHistory extends StatefulWidget {
  final ClsParty Party;

  const CustomerHistory({required this.Party, Key? key}) : super(key: key);

  static const String routeName = '/customerhistory';

  static Route route({required ClsParty routedParty}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => CustomerHistory(Party: routedParty),
    );
  }

  @override
  State<CustomerHistory> createState() => _CustomerHistoryState(Party);
}

class _CustomerHistoryState extends State<CustomerHistory> {
  ClsParty Party;

  _CustomerHistoryState(this.Party);

  late List<ClsCustomerHistory> CustHistory;
  bool loading = true;
  Color StatusColor = Colors.black;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Api.getCustomerHistory(Party.PartySno, context).then((value) => {
          setState(() {
            CustHistory = value;
            loading = false;
          })
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer History"),
        backgroundColor: Colors.white, //background color of app bar
        foregroundColor: Colors.deepOrangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32)),
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                  Colors.blue), //choose your own color
            ))
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25.0),
                          //topRight: Radius.circular(25.0),
                          //topLeft: Radius.circular(25.0),
                          //bottomRight: Radius.circular(25.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.4 * 1),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text(
                            Party.Party_Name,
                            style: TextStyle(
                                fontFamily: gFontName,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Code: " + Party.Party_Code,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Party.Rel == 0
                                            ? Text("S/o ")
                                            : Text(""),
                                        Party.Rel == 1
                                            ? Text("D/o ")
                                            : Text(""),
                                        Party.Rel == 2
                                            ? Text("W/o ")
                                            : Text(""),
                                        Party.Rel == 3
                                            ? Text("C/o ")
                                            : Text(""),
                                        Text(
                                          Party.RelName,
                                          style:
                                              TextStyle(fontFamily: gFontName),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      Party.Address1 + ', ' + Party.Address2,
                                      style: TextStyle(
                                          fontFamily: gFontName, fontSize: 16),
                                    ),
                                    Text(
                                      Party.Address3,
                                      style: TextStyle(
                                          fontFamily: gFontName, fontSize: 16),
                                    ),
                                    Text(
                                      Party.Address4,
                                      style: TextStyle(
                                          fontFamily: gFontName, fontSize: 16),
                                    ),
                                    Text(
                                      Party.City,
                                      style: TextStyle(
                                          fontFamily: gFontName, fontSize: 16),
                                    ),
                                    Text(
                                      Party.Area_Name,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      Party.Mobile,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Open Loans : " +
                                          CustHistory[0].LiveLoans.toString(),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.green),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Ready for Auction : " +
                                          CustHistory[0]
                                              .ReadyforAuction
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.red),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Closed Loans : " +
                                          CustHistory[0].Terminated.toString(),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.blueGrey),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Auctioned Loans : " +
                                          CustHistory[0].Auctioned.toString(),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: CustHistory.length,
                        itemBuilder: (context, index) {
                          (CustHistory[index].Status == 2)
                              ? StatusColor = Colors.green
                              : (CustHistory[index].Status == 1)
                                  ? StatusColor = Colors.blueGrey
                                  : (CustHistory[index].Status == 3)
                                      ? StatusColor = Colors.red
                                      : (CustHistory[index].Status == 4)
                                          ? StatusColor = Colors.black
                                          : StatusColor = Colors.blueAccent;

                          return
                              // DayRecords[index].LedSno == 2 ? SizedBox(height: .001,) :
                              InkWell(
                            onTap: () {
                              Navigator.push(
                                // or pushReplacement, if you need that
                                context,
                                FadeInRoute(
                                  routeName: "/loansummary",
                                  page: LoanSummary(
                                    LoanSno: CustHistory[index].LoanSno,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: StatusColor, width: 3),
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.4 * 1),
                                      offset: const Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        CustHistory[index].Loan_No,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      (CustHistory[index].Status == 2)
                                          ? Text("Open",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: StatusColor))
                                          : (CustHistory[index].Status == 1)
                                              ? Text("Closed",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: StatusColor))
                                              : (CustHistory[index].Status == 3)
                                                  ? Text("Ready for Auction",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: StatusColor))
                                                  : (CustHistory[index]
                                                              .Status ==
                                                          4)
                                                      ? Text("Auctioned",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  StatusColor))
                                                      : Text("Unknown",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  StatusColor)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    child: Container(
                                      height: 2,
                                      width: double.infinity,
                                      color: StatusColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Loan Date: " +
                                          DateFormat('dd-MM-yyyy')
                                              .format(
                                                  CustHistory[index].Loan_Date)
                                              .toString()),
                                      Text(
                                        "Principal: " +
                                            CustHistory[index]
                                                .Principal
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Advance Int: " +
                                          CustHistory[index]
                                              .AdvInt_Amount
                                              .toString()),
                                      Text("Nett Amt: " +
                                          CustHistory[index]
                                              .NettAmt
                                              .toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Gross Wt: " +
                                          CustHistory[index]
                                              .TotGrossWt
                                              .toString()),
                                      Text("Nett Wt: " +
                                          CustHistory[index]
                                              .TotNettWt
                                              .toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(CustHistory[index].Dur_Months == 0
                                          ? ""
                                          : "Duration :" +
                                                      CustHistory[index]
                                                          .Dur_Months
                                                          .toString() +
                                                      " months, " +
                                                      CustHistory[index]
                                                          .Dur_Days
                                                          .toString() ==
                                                  0
                                              ? ""
                                              : CustHistory[index]
                                                      .Dur_Days
                                                      .toString() +
                                                  " days"),
                                      Text("Closed on: " +
                                          CustHistory[index]
                                              .Red_Date
                                              .toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Items: " + CustHistory[index].ItemDetails,
                                    style: TextStyle(fontFamily: gFontName),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
