import 'package:finacc/classes/ClsLoanSummary.dart';
import 'package:finacc/config/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/globals.dart';

class LoanSummary extends StatefulWidget {
  final int LoanSno;

  const LoanSummary({required this.LoanSno, Key? key}) : super(key: key);

  static const String routeName = '/loansummary';

  static Route route({required int RoutedLoanSno}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => LoanSummary(LoanSno: RoutedLoanSno),
    );
  }

  @override
  State<LoanSummary> createState() => _LoanSummaryState(LoanSno);
}

class _LoanSummaryState extends State<LoanSummary> {
  var formatter = NumberFormat('#,##,000');
  int LoanSno;

  _LoanSummaryState(this.LoanSno);

  bool loading = true;
  Color StatusColor = Colors.black;
  late List<ClsLoanSummary> LoanSummary;
  late List LoanTrans;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Api.getLoanSummary(LoanSno, context).then((value) => {
          setState(() {
            LoanSummary = value[0];
            LoanTrans = value[1];
            (LoanSummary[0].Status == 2)
                ? StatusColor = Colors.green
                : (LoanSummary[0].Status == 1)
                    ? StatusColor = Colors.blueGrey
                    : (LoanSummary[0].Status == 3)
                        ? StatusColor = Colors.red
                        : (LoanSummary[0].Status == 4)
                            ? StatusColor = Colors.black
                            : StatusColor = Colors.blueAccent;
            loading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Summary"),
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
          : Container(
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loan No:  " + LoanSummary[0].Loan_No,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: StatusColor),
                            ),
                            Text(
                              "Amount:  " +
                                  formatter.format(LoanSummary[0].Principal),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: StatusColor),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.circle,
                              color: StatusColor,
                            ),
                            LoanSummary[0].Status == 1
                                ? Text(
                                    "Closed",
                                    style: TextStyle(fontSize: 20),
                                  )
                                : LoanSummary[0].Status == 2
                                    ? Text(
                                        "Open",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    : LoanSummary[0].Status == 3
                                        ? Text(
                                            "Ready for Auction",
                                            style: TextStyle(fontSize: 20),
                                          )
                                        : LoanSummary[0].Status == 4
                                            ? Text(
                                                "Auctioned",
                                                style: TextStyle(fontSize: 20),
                                              )
                                            : Text(
                                                "Unknown",
                                                style: TextStyle(fontSize: 20),
                                              )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 20,
                      color: StatusColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LoanSummary[0].Party_Name,
                          style: TextStyle(
                              fontFamily: gFontName,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LoanSummary[0].Area_Name,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LoanSummary[0].Mobile,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Divider(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Loan Date',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Mature Date',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd-MM-yyyy')
                              .format(LoanSummary[0].Loan_Date),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('dd-MM-yyyy')
                              .format(LoanSummary[0].Mature_Date),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Group',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Scheme',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LoanSummary[0].Grp_Name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          LoanSummary[0].IntTypeName,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Weights',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Duration',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gross: ' +
                              LoanSummary[0].TotGrossWt.toString() +
                              'Nett: ' +
                              LoanSummary[0].TotNettWt.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          LoanSummary[0].Dur_Months.toString() +
                              ' Months ' +
                              LoanSummary[0].Dur_Days.toString() +
                              ' Days',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Principal Balance',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Interest Balance',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatter.format(LoanSummary[0].Principal_Balance),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          formatter.format(LoanSummary[0].Interest_Balance),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Nett Payable',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          formatter.format(LoanSummary[0].NettAmt_Balance),
                          style: TextStyle(
                              fontSize: 18,
                              color: StatusColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(
                      height: 20,
                      thickness: 2,
                      color: StatusColor,
                    ),
                    Text("Loan Statement"),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: LoanTrans.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Card(
                                child: ListTile(
                                  title: Text(DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          LoanTrans[0]['VouDate']['date']))),
                                  subtitle: LoanTrans[index]['RecType'] == 1
                                      ? Text("Loan No: " +
                                          LoanTrans[index]['VouNo'])
                                      : LoanTrans[index]['RecType'] == 2
                                          ? Text("Loan Topup " +
                                              LoanTrans[index]['VouNo'])
                                          : LoanTrans[index]['RecType'] == 3
                                              ? Text("Receipt No: " +
                                                  LoanTrans[index]['VouNo'])
                                              : LoanTrans[index]['RecType'] == 4
                                                  ? Text("Redemption No: " +
                                                      LoanTrans[index]['VouNo'])
                                                  : Text(LoanTrans[index]
                                                      ['VouNo']),
                                  trailing: LoanTrans[index]['RecType'] == 1
                                      ? Text(
                                          formatter.format(double.parse(
                                              LoanTrans[index]['Amount'])),
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 16),
                                        )
                                      : LoanTrans[index]['RecType'] == 2
                                          ? Text(
                                              formatter.format(double.parse(
                                                  LoanTrans[index]['Amount'])),
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16),
                                            )
                                          : LoanTrans[index]['RecType'] == 3
                                              ? Text(
                                                  formatter.format(double.parse(
                                                      LoanTrans[index]
                                                          ['Amount'])),
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 16),
                                                )
                                              : LoanTrans[index]['RecType'] == 4
                                                  ? Text(
                                                      formatter.format(
                                                          double.parse(
                                                              LoanTrans[index]
                                                                  ['Amount'])),
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 16),
                                                    )
                                                  : Text(
                                                      formatter.format(
                                                          double.parse(
                                                              LoanTrans[index]
                                                                  ['Amount'])),
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16),
                                                    ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ),
    );
  }
}
