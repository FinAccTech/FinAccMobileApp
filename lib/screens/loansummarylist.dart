import 'package:finacc/widgets/loanlist.dart';
import 'package:flutter/material.dart';

class LoanSummaryList extends StatelessWidget {
  const LoanSummaryList({Key? key}) : super(key: key);

  static const String routeName = '/loansummarylist';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => LoanSummaryList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Loans List"),
          backgroundColor: Colors.white, //background color of app bar
          foregroundColor: Colors.deepOrangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32)),
          ),
        ),
        body: LoanList(
          LnStatus: 0,
        ));
  }
}
