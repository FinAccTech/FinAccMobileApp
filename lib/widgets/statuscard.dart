import 'package:finacc/classes/ClsStatus.dart';
import 'package:finacc/config/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finacc/config/globals.dart' as Globals;
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

class StatusCard extends StatefulWidget {
  const StatusCard({Key? key}) : super(key: key);

  @override
  State<StatusCard> createState() => _StatusCardState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _StatusCardState extends State<StatusCard> {
// List<ClsStatus> StatusData;
// _StatusCardState(this.StatusData);
  var formatter = NumberFormat('#,##,000');
  List<ClsStatus> StatusData = [];

  String dropdownText = 'Last 7 Days';
  int dropdownvalue = 1;
  bool loading = true;
  var CloseBal = 0;
  var StrCloseBal = "";

  @override
  void initState() {
    // TODO: implement initState
    Api.getStatusCard(1, context).then((retrs) => {
          Api.getDayBook(DateTime.now(), context).then((value) => {
                CloseBal = value[2],
                StrCloseBal = formatter.format(value[2]),
                StatusData = retrs,
                setState(() {
                  loading = false;
                })
              }),
        });
  }

  void _showPopupMenu(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem(
          value: 1,
          child: Text("Last 7 Days"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Today"),
        ),
        PopupMenuItem(
          value: 3,
          child: Text("Last Month"),
        ),
        PopupMenuItem(
          value: 4,
          child: Text("Last Year"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

      if (value != null) loading = true;

      Api.getStatusCard(value!, context).then((retrs) => {
            setState(() {
              StatusData = retrs;
              loading = false;
              dropdownvalue = value;
              switch (value) {
                case 1:
                  dropdownText = "Last 7 Days";
                  break;
                case 2:
                  dropdownText = "Today";
                  break;
                case 3:
                  dropdownText = "Past Month";
                  break;
                case 4:
                  dropdownText = "Past Year";
                  break;
              }
            })
          });
    });
  }

  Map<String, double> dataMap = {
    "CurrBalance": 5,
    "Limit": 3,
  };

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Colors.blue), //choose your own color
          ))
        : Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //borderRadius: BorderRadius.only(topRight: Radius.circular(84)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey,
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 20),
              ],
            ),
            child: loading
                ? Center(
                    child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.blue), //choose your own color
                  ))
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Globals.Comp_Name.length > 22
                                  ? Globals.Comp_Name.substring(0, 22) + "..."
                                  : Globals.Comp_Name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      loading = true;
                                      Api.getStatusCard(dropdownvalue, context)
                                          .then((retrs) => {
                                                Api.getDayBook(
                                                        DateTime.now(), context)
                                                    .then((value) =>
                                                        {CloseBal = value[2]}),
                                                setState(() {
                                                  StatusData = retrs;
                                                  loading = false;
                                                })
                                              });
                                    },
                                    icon: Icon(
                                      CupertinoIcons.refresh,
                                      size: 20,
                                      color: Colors.green,
                                    )),
                                Text(dropdownText),
                                GestureDetector(
                                  onTapDown: (TapDownDetails details) {
                                    _showPopupMenu(details.globalPosition);
                                  },
                                  child: Container(
                                      child: Icon(
                                    Icons.more_vert_sharp,
                                    color: Colors.blueAccent,
                                  )),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Container(
                                          width: 4,
                                          height: 50,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Fresh Loans"),
                                              Text(
                                                formatter.format(
                                                    StatusData[0].FreshLoans),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '(' +
                                            StatusData[0]
                                                .FreshCount
                                                .toString() +
                                            ')',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      StatusData[0].FreshLoans >=
                                              StatusData[0].PrevFreshLoans
                                          ? Image.asset(
                                              "assets/images/uparrow.png",
                                              width: 30,
                                              height: 40,
                                            )
                                          : Image.asset(
                                              "assets/images/downarrow.png",
                                              width: 30,
                                              height: 40,
                                            )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Container(
                                          width: 4,
                                          height: 50,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Old Loans"),
                                              Text(
                                                formatter.format(
                                                    StatusData[0].OldLoans),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '(' +
                                            StatusData[0].OldCount.toString() +
                                            ')',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      StatusData[0].OldLoans >=
                                              StatusData[0].PrevOldLoans
                                          ? Image.asset(
                                              "assets/images/uparrow.png",
                                              width: 30,
                                              height: 40,
                                            )
                                          : Image.asset(
                                              "assets/images/downarrow.png",
                                              width: 30,
                                              height: 40,
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  PieChart(
                                    dataMap: dataMap,
                                    animationDuration:
                                        Duration(milliseconds: 800),
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 5.2,
                                    initialAngleInDegree: 0,
                                    chartType: ChartType.ring,
                                    colorList: [Colors.orange, Colors.green],
                                    ringStrokeWidth: 24,
                                    centerText: "Cash",
                                    legendOptions: LegendOptions(
                                      showLegendsInRow: false,
                                      legendPosition: LegendPosition.right,
                                      showLegends: false,
                                    ),
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValueBackground: false,
                                      showChartValues: false,
                                      showChartValuesInPercentage: true,
                                      showChartValuesOutside: false,
                                      decimalPlaces: 1,
                                    ),
                                    // gradientList: ---To add gradient colors---
                                    // emptyColorGradient: ---Empty Color gradient---
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CloseBal < 0
                                      ? Text(
                                          StrCloseBal.substring(
                                                  1, StrCloseBal.length) +
                                              " Cr",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          StrCloseBal + " Dr",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text("Loans"),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: Container(
                                      height: 3,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    formatter.format(StatusData[0].Loans),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text("Receipts"),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: Container(
                                      height: 3,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    formatter.format(StatusData[0].Receipts),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text("Redemptions"),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: Container(
                                      height: 3,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    formatter.format(StatusData[0].Redemptions),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
  }
}
