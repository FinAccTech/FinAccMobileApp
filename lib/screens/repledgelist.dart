import 'dart:async';
import 'package:finacc/classes/ClsRepledge.dart';
import 'package:finacc/config/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RepledgeList extends StatefulWidget {
  const RepledgeList({Key? key}) : super(key: key);

  static const String routeName = '/repledgelist';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => RepledgeList(),
    );
  }

  @override
  State<RepledgeList> createState() => _RepledgeListState();
}

class _RepledgeListState extends State<RepledgeList> {
  var formatter = NumberFormat('#,##,000');
  final scrollController = ScrollController();
  Timer? _debounce;
  bool searchmode = false;
  List<ClsRepledge> _Accounts = <ClsRepledge>[];
  List<ClsRepledge> _AccountsDisplay = <ClsRepledge>[];

  int pageNumber = 1;
  int recordCount = 30;

  @override
  void initState() {
    // TODO: implement initState
    Api.getRepledgeList(pageNumber, recordCount, context).then((value) {
      setState(() {
        _Accounts.addAll(value);
        _AccountsDisplay = _Accounts;
        scrollController.addListener(_scrollListener);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Repledge List"),
          backgroundColor: Colors.white, //background color of app bar
          foregroundColor: Colors.deepOrangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32)),
          ),
        ),
        body: ListView(children: [
          _searchBar(),
          Container(
            height: 800,
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: _AccountsDisplay.length,
              itemBuilder: (context, index) {
                if (_AccountsDisplay.length > 0) {
                  return _listItem(index);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ]));
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Type here to Search..."),
            onChanged: (text) {
              text = text.toLowerCase();
              setState(() {
                String StrTxt = text;
                if (text.contains("\\")) {
                  StrTxt = text.replaceAll("\\", "");
                }

                if (StrTxt.length == 0) {
                  _AccountsDisplay = _Accounts;
                }
                if (StrTxt.length < 3) {
                  searchmode = true;
                } else {
                  searchmode = false;
                  _onSearchChanged(StrTxt);
                }
              });
            },
          ),
          searchmode == true
              ? Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Type min 3 Chars for search",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )
              : Text(""),
        ],
      ),
    );
  }

  getFilterRs(text) {
    return _Accounts.where((element) {
      var nameTitle = element.Loan_No.toLowerCase();
      return nameTitle.contains(text);
    }).toList();
  }

  _listItem(index) {
    return InkWell(
      onTap: () {
        //     Navigator.pushNamed(context, "/loansummary", arguments: _AccountsDisplay[index].LoanSno);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
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
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rp: " +
                        _AccountsDisplay[index].Repledge_No +
                        " Ln: " +
                        _AccountsDisplay[index].Loan_No,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(DateFormat('dd-MM-yyyy')
                          .format(_AccountsDisplay[index].Repledge_Date) +
                      ' Ref No:' +
                      _AccountsDisplay[index].Ref_No),
                  Text(
                    _AccountsDisplay[index].Party_Name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(_AccountsDisplay[index].BankName),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatter.format(_AccountsDisplay[index].RpAmount),
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  Text(
                    "(" +
                        formatter.format(_AccountsDisplay[index].LnAmount) +
                        ")",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getNewPage();
    }
  }

  void getNewPage() {
    pageNumber = pageNumber + 1;
    Api.getRepledgeList(pageNumber, recordCount, context).then((value) {
      setState(() {
        //value = value +_Accounts;
        _Accounts = _Accounts + value;
        _AccountsDisplay = _Accounts;
      });
    });
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      Api.getFilteredRepledgeList(query, context).then((value) => {
            setState(() {
              _AccountsDisplay = value;
            })
          });
    });
  }
}
