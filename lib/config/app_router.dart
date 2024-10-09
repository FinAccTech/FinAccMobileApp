import 'package:finacc/classes/ClsParty.dart';
import 'package:finacc/screens/auctionhistory.dart';
import 'package:finacc/screens/companies.dart';
import 'package:finacc/screens/customerhistory.dart';
import 'package:finacc/screens/dashboard.dart';
import 'package:finacc/screens/daybook.dart';
import 'package:finacc/screens/loanhistory.dart';
import 'package:finacc/screens/pingeneration.dart';
import 'package:finacc/screens/receiptslist.dart';
import 'package:finacc/screens/repledgelist.dart';
import 'package:finacc/screens/settings.dart';
import 'package:finacc/screens/loansummary.dart';
import 'package:finacc/screens/loansummarylist.dart';
import 'package:finacc/screens/login.dart';
import 'package:finacc/screens/partylist.dart';
import 'package:finacc/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:finacc/config/globals.dart' as Globals;

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        if (Globals.IsLoggedIn == true) {
          return Dashboard.route();
        } else {
          return Login.route();
        }

      case Dashboard.routeName:
        return Dashboard.route();

      case AppSettings.routeName:
        return AppSettings.route();

      case DayBook.routeName:
        return DayBook.route();

      case AuctionHistory.routeName:
        return AuctionHistory.route();

      case PartyList.routeName:
        return PartyList.route();

      case CustomerHistory.routeName:
        return CustomerHistory.route(
            routedParty: settings.arguments as ClsParty);

      case LoanSummary.routeName:
        return LoanSummary.route(RoutedLoanSno: settings.arguments as int);

      case LoanSummaryList.routeName:
        return LoanSummaryList.route();

      case LoanHistory.routeName:
        return LoanHistory.route();

      case RepledgeList.routeName:
        return RepledgeList.route();

      case ReceiptsList.routeName:
        return ReceiptsList.route();

      case PinGeneration.routeName:
        return PinGeneration.route();

      case Splash.routeName:
        return Splash.route();

      case Companies.routeName:
        return Companies.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: RouteSettings(name: 'Error'),
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text("Routing Error"),
              ),
            ));
  }
}
