import 'package:finacc/classes/ClsAuctionList.dart';
import 'package:finacc/config/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/globals.dart';

class AuctionHistory extends StatefulWidget {
  const AuctionHistory({Key? key}) : super(key: key);

  static const String routeName = '/auctionhistory';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => AuctionHistory(),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _AuctionHistory();
  }
}

class _AuctionHistory extends State<AuctionHistory> {
  var formatter = NumberFormat('#,##,000');
  TextEditingController dateInput = TextEditingController();
  bool loading = true;
  late List<ClsAuctionList> AuctionList;

  @override
  void initState() {
    //dateInput.text = ""; //set the initial value of text field
    super.initState();
    dateInput.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    Api.getAuctionHistory(DateTime.now(), context).then((value) => {
          AuctionList = value,
          setState(() {
            loading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ready for Auction"),
          backgroundColor: Colors.white, //background color of app bar
          foregroundColor: Colors.deepOrangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32)),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            // height: MediaQuery.of(context).size.width / 3,
            child: Column(
              children: [
                TextField(
                  controller: dateInput,
                  //editing controller of this TextField
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Ready for Auction as on" //label text of field
                      ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      Api.getAuctionHistory(pickedDate, context)
                          .then((value) => {
                                setState(() {
                                  AuctionList = value;
                                  loading = false;
                                })
                              });

                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dateInput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4 * 1),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: loading
                      ? Center(
                          child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.blue), //choose your own color
                        ))
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text("Total Loans:",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(AuctionList.length.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        "assets/images/whatsapp.webp",
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    Text("WhatsApp")
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        "assets/images/sms.png",
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    Text("Send Sms")
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                          ],
                        ),
                ),
                loading
                    ? Center(
                        child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.blue), //choose your own color
                      ))
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: AuctionList.length,
                        itemBuilder: (context, index) {
                          return
                              // DayRecords[index].LedSno == 2 ? SizedBox(height: .001,) :
                              Container(
                                  padding: EdgeInsets.all(15),
                                  margin: EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color:
                                              Colors.grey.withOpacity(0.4 * 1),
                                          offset: const Offset(1.1, 1.1),
                                          blurRadius: 10.0),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AuctionList[index]
                                                        .Party_Name
                                                        .length >
                                                    33
                                                ? AuctionList[index]
                                                    .Party_Name
                                                    .substring(0, 33)
                                                : AuctionList[index].Party_Name,
                                            style: TextStyle(
                                                fontFamily: gFontName),
                                          ),
                                          Text(
                                            AuctionList[index].Loan_No +
                                                ' / ' +
                                                DateFormat('dd-MM-yyyy')
                                                    .format(AuctionList[index]
                                                        .Loan_Date)
                                                    .toString(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            "Notices Sent: " +
                                                AuctionList[index]
                                                    .Reminders_Sent
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            AuctionList[index].Grp_Name,
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          AuctionList[index].Principal >
                                                  AuctionList[index]
                                                      .Market_Value
                                              ? Text(
                                                  AuctionList[index]
                                                      .Principal
                                                      .toStringAsFixed(0),
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : Text(
                                                  AuctionList[index]
                                                      .Principal
                                                      .toStringAsFixed(0),
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                          Text(
                                            'Mkt Val: ' +
                                                AuctionList[index]
                                                    .Market_Value
                                                    .toStringAsFixed(0),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ));
                        },
                      ),
              ],
            ),
          ),
        ));
  }
}
