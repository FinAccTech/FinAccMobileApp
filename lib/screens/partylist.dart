import 'dart:async';

import 'package:finacc/classes/ClsParty.dart';
import 'package:finacc/config/api.dart';
import 'package:finacc/config/globals.dart';
import 'package:finacc/screens/customerhistory.dart';
import 'package:finacc/widgets/fadetransition.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PartyList extends StatefulWidget {
  const PartyList({Key? key}) : super(key: key);

  static const String routeName = '/partylist';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => PartyList(),
    );
  }

  @override
  State<PartyList> createState() => _PartyListState();
}

class _PartyListState extends State<PartyList> {
  final scrollController = ScrollController();
  Timer? _debounce;
  bool searchmode = false;

  List<ClsParty> _Accounts = <ClsParty>[];
  List<ClsParty> _AccountsDisplay = <ClsParty>[];

  int pageNumber = 1;
  int recordCount = 30;

  @override
  void initState() {
    // TODO: implement initState

    Api.getPartyList(pageNumber, recordCount, context).then((value) {
      setState(() {
        _Accounts.addAll(value);
        _AccountsDisplay = _Accounts;
        scrollController.addListener(_scrollListener);
      });
    });
    //Api.sendData();
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
        title: Text("Customers List"),
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
      ]),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: "Search by Name..."),
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
      var nameTitle = element.Party_Name.toLowerCase();
      return nameTitle.contains(text);
    }).toList();
  }

  _listItem(index) {
    return InkWell(
      onTap: () {
        //Navigator.pushNamed(context, "/customerhistory", arguments: _AccountsDisplay[index]);
        Navigator.push(
          // or pushReplacement, if you need that
          context,
          FadeInRoute(
            routeName: "/customerhistory",
            page: CustomerHistory(
              Party: _AccountsDisplay[index],
            ),
          ),
        );
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
                    _AccountsDisplay[index].Party_Name.length > 25
                        ? _AccountsDisplay[index].Party_Name.substring(0, 25)
                        : _AccountsDisplay[index].Party_Name,
                    style: TextStyle(
                        fontFamily: gFontName,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      _AccountsDisplay[index].Rel == 0
                          ? Text("S/o ")
                          : Text(""),
                      _AccountsDisplay[index].Rel == 1
                          ? Text("D/o ")
                          : Text(""),
                      _AccountsDisplay[index].Rel == 2
                          ? Text("W/o ")
                          : Text(""),
                      _AccountsDisplay[index].Rel == 3
                          ? Text("C/o ")
                          : Text(""),
                      Text(_AccountsDisplay[index].RelName),
                    ],
                  ),
                  Text(_AccountsDisplay[index].Area_Name),
                  Text(_AccountsDisplay[index].Mobile),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            launch("tel://" + _AccountsDisplay[index].Mobile);
                          },
                          icon: Image.asset(
                            "assets/images/call.png",
                            width: 30,
                            height: 30,
                          )),
                      IconButton(
                          onPressed: () {
                            launch("https://wa.me/" +
                                _AccountsDisplay[index].Mobile +
                                "?text=Hello");
                          },
                          icon: Image.asset(
                            "assets/images/whatsapp.webp",
                            width: 30,
                            height: 30,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/images/sms.png",
                            width: 30,
                            height: 30,
                          )),
                    ],
                  )
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
    Api.getPartyList(pageNumber, recordCount, context).then((value) {
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
      Api.getFilteredPartyList(query, context).then((value) => {
            setState(() {
              _AccountsDisplay = value;
            })
          });
      // do something with query
    });
  }
}
