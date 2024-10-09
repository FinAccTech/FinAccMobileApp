import 'package:finacc/classes/ClsTransactions.dart';
import 'package:finacc/config/api.dart';
import 'package:finacc/config/globals.dart';
import 'package:flutter/material.dart';

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({Key? key}) : super(key: key);

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  @override
  List<ClsTransactions> Transactions = [];

  bool loading = true;

  void initState() {
    print(gFontName);
    // TODO: implement initState
    Api.getRecentTransactions(context).then((value) => {
          Transactions = value,
          setState(() {
            loading = false;
          })
        });
    super.initState();
  }

  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Colors.blue), //choose your own color
          ))
        : Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey,
                    offset: const Offset(0, 3),
                    blurRadius: 10),
              ],
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.track_changes),
                        Text(
                          "Recent Transactions",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Container(
                              width: 60,
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "More",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ))
                      ],
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      Transactions[index].Party.length > 30
                                          ? Transactions[index]
                                              .Party
                                              .substring(0, 30)
                                          : Transactions[index].Party,
                                      style: TextStyle(fontFamily: gFontName),
                                    ),
                                    Text(
                                      '(' + Transactions[index].TransNo + ')',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Text(Transactions[index]
                                    .Amount
                                    .toStringAsFixed(0))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Transactions[index].IGrp,
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  Transactions[index].TransType,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        );
                      },
                    )
                  ],
                )));
  }
}
