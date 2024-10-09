import 'package:finacc/classes/ClsDaybook.dart';
import 'package:finacc/config/api.dart';
import 'package:finacc/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayBook extends StatefulWidget {
  const DayBook({Key? key}) : super(key: key);

  static const String routeName = '/daybook';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => DayBook(),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _DayBook();
  }
}

class _DayBook extends State<DayBook> {
  var formatter = NumberFormat('#,##,000');
  TextEditingController dateInput = TextEditingController();
  bool loading = true;
  late List<ClsDayBook> DayRecords;
  var OpenBal;
  var CloseBal;
  String StrOpenBal = "";
  String StrCloseBal = "";

  @override
  void initState() {
    print(gFontName);
    //dateInput.text = ""; //set the initial value of text field
    super.initState();

    dateInput.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    Api.getDayBook(DateTime.now(), context).then((value) => {
          DayRecords = value[0],
          OpenBal = value[1],
          CloseBal = value[2],
          StrOpenBal = formatter.format(value[1]),
          StrCloseBal = formatter.format(value[2]),
          setState(() {
            loading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DayBook"),
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
                      labelText: "Enter Date" //label text of field
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
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      Api.getDayBook(pickedDate, context).then((value) => {
                            setState(() {
                              DayRecords = value[0];
                              OpenBal = value[1];
                              CloseBal = value[2];
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
                      topRight: Radius.circular(25.0),
                      topLeft: Radius.circular(25.0),
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
                              Colors.white), //choose your own color
                        ))
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Opening Balance",
                                    style: TextStyle(color: Colors.blueAccent)),
                                Text("Closing Balance",
                                    style: TextStyle(color: Colors.blueAccent)),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  OpenBal < 0
                                      ? Text(
                                          StrOpenBal.substring(
                                                  1,
                                                  StrOpenBal.toString()
                                                      .length) +
                                              " Cr",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          StrOpenBal + " Dr",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                  CloseBal < 0
                                      ? Text(
                                          StrCloseBal.substring(
                                                  1,
                                                  StrCloseBal.toString()
                                                      .length) +
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
                                ]),
                          ],
                        ),
                ),
                loading
                    ? Center(
                        child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.white), //choose your own color
                      ))
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: DayRecords.length,
                        itemBuilder: (context, index) {
                          return DayRecords[index].LedSno == 2
                              ? SizedBox(
                                  height: .001,
                                )
                              : AnimatedContainer(
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
                                  duration: Duration(seconds: 5),
                                  curve: Curves.fastOutSlowIn,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DayRecords[index].Led_Name,
                                              style: TextStyle(
                                                  fontFamily: gFontName),
                                            ),
                                            Text(
                                              DayRecords[index].Narration,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      DayRecords[index]
                                                  .Credit
                                                  .toStringAsFixed(0) ==
                                              "0"
                                          ? Row(
                                              children: [
                                                Text(
                                                    formatter.format(
                                                        DayRecords[index]
                                                            .Debit),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.red)),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "Dr",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.red),
                                                )
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Text(
                                                    formatter.format(
                                                        DayRecords[index]
                                                            .Credit),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.green)),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text("Cr",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.green,
                                                    ))
                                              ],
                                            ),
                                    ],
                                  )
                                  // Row(
                                  //   children: <Widget>[
                                  //     Expanded(
                                  //       flex : 4,
                                  //       child: Align(
                                  //         alignment: Alignment.centerLeft,
                                  //         child: Container(
                                  //           color: Colors.white,
                                  //           child: Column(
                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                  //             children: [
                                  //               Text( DayRecords[index].Led_Name ),
                                  //               Text( DayRecords[index].Narration, style: TextStyle(fontSize: 12),),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //       child: Align(
                                  //         alignment: Alignment.centerRight,
                                  //         child: Container(
                                  //           color: Colors.white,
                                  //           child: Text(DayRecords[index].Credit.toStringAsFixed(0) == "0" ? "" :  formatter.format(DayRecords[index].Credit), style: TextStyle( fontSize: 16, color: Colors.red),),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //       child: Align(
                                  //         alignment: Alignment.centerRight,
                                  //         child: Container(
                                  //           color: Colors.white,
                                  //           child: Text(DayRecords[index].Debit.toStringAsFixed(0) == "0" ? "" : formatter.format(DayRecords[index].Debit), style: TextStyle( fontSize: 16, color: Colors.green),),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  );
                        },
                      ),
              ],
            ),
          ),
        ));
  }
}
