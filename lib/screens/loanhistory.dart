import 'dart:async';

import 'package:finacc/classes/ClsLoan.dart';
import 'package:finacc/config/api.dart';
import 'package:finacc/widgets/loanlist.dart';
import 'package:flutter/material.dart';

class LoanHistory extends StatefulWidget {
  const LoanHistory({super.key});

  static const String routeName = '/loanhistory';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => LoanHistory(),
    );
  }

  @override
  State<LoanHistory> createState() => _LoanHistoryState();
}

class _LoanHistoryState extends State<LoanHistory>
    with SingleTickerProviderStateMixin {
  @override
  late TabController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = TabController(length: 5, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan History"),
        backgroundColor: Colors.white, //background color of app bar
        foregroundColor: Colors.orange,

        // actions: [
        //   IconButton(icon: Icon(Icons.search), onPressed: () {}),
        //   PopupMenuButton<String>(
        //     onSelected: (value) {
        //       print(value);
        //     },
        //     itemBuilder: (BuildContext contesxt) {
        //       return [
        //         PopupMenuItem(
        //           child: Text("New group"),
        //           value: "New group",
        //         ),
        //         PopupMenuItem(
        //           child: Text("New broadcast"),
        //           value: "New broadcast",
        //         ),
        //         PopupMenuItem(
        //           child: Text("Whatsapp Web"),
        //           value: "Whatsapp Web",
        //         ),
        //         PopupMenuItem(
        //           child: Text("Starred messages"),
        //           value: "Starred messages",
        //         ),
        //         PopupMenuItem(
        //           child: Text("Settings"),
        //           value: "Settings",
        //         ),
        //       ];
        //     },
        //   )
        // ],
        bottom: TabBar(
          controller: ctrl,
          isScrollable: true,
          onTap: (index) {},
          tabs: [
            Tab(
              child: Text(
                "Live",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            Tab(
              child: Text(
                "Open",
                style: TextStyle(color: Colors.green),
              ),
            ),
            Tab(
              child: Text(
                "Auction Ready",
                style: TextStyle(color: Colors.red),
              ),
            ),
            Tab(
              child: Text(
                "Auctioned",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                "Closed",
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: ctrl,
        children: [
          LoanList(LnStatus: 5),
          LoanList(LnStatus: 2),
          LoanList(LnStatus: 3),
          LoanList(LnStatus: 4),
          LoanList(LnStatus: 1),
        ],
      ),
    );
  }
}
