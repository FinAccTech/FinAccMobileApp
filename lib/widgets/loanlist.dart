import 'dart:async';

import 'package:finacc/classes/ClsLoan.dart';
import 'package:finacc/classes/ClsParty.dart';
import 'package:finacc/config/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/globals.dart';

class LoanList extends StatefulWidget {
  final int LnStatus;

  const LoanList({required this.LnStatus, Key? key}) : super(key: key);

  @override
  State<LoanList> createState() => _LoanListState(LnStatus);
}

class _LoanListState extends State<LoanList> {
  int LnStatus;

  _LoanListState(this.LnStatus);

  final scrollController = ScrollController();
  Timer? _debounce;
  bool searchmode = false;
  List<ClsLoan> _Accounts = <ClsLoan>[];
  List<ClsLoan> _AccountsDisplay = <ClsLoan>[];

  int pageNumber = 1;
  int recordCount = 30;

  @override
  void initState() {
    // TODO: implement initState
    Api.getLoansList(LnStatus, pageNumber, recordCount, context).then((value) {
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
    return ListView(children: [
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
    ]);
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
        Navigator.pushNamed(context, "/loansummary",
            arguments: _AccountsDisplay[index].LoanSno);
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
                    _AccountsDisplay[index].Loan_No,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _AccountsDisplay[index].Party_Name,
                    style: TextStyle(
                      fontFamily: gFontName,
                    ),
                  ),
                  Text(DateFormat('dd-MM-yyyy')
                      .format(_AccountsDisplay[index].Loan_Date)),
                ],
              ),
              Text(
                _AccountsDisplay[index].Principal.toString(),
                style: TextStyle(color: Colors.green),
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
    Api.getLoansList(LnStatus, pageNumber, recordCount, context).then((value) {
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
      Api.getFilteredLoansList(LnStatus, query, context).then((value) => {
            setState(() {
              _AccountsDisplay = value;
            })
          });
      // do something with query
    });
  }
}
