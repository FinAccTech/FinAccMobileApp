import 'dart:io';
import 'package:finacc/config/api.dart';
import 'package:finacc/config/customicons.dart';
import 'package:finacc/screens/companies.dart';
import 'package:finacc/screens/loanhistory.dart';
import 'package:finacc/screens/login.dart';
import 'package:finacc/screens/pingeneration.dart';
import 'package:finacc/screens/receiptslist.dart';
import 'package:finacc/screens/repledgelist.dart';
import 'package:finacc/screens/settings.dart';
import 'package:finacc/widgets/fadetransition.dart';
import 'package:finacc/widgets/recenttransactions.dart';
import 'package:finacc/widgets/reportslinkcard.dart';
import 'package:finacc/widgets/statuscard.dart';
import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:finacc/config/globals.dart' as Globals;
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/ClsTransactions.dart';
import '../config/globals.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const String routeName = '/dashboard';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => Dashboard(),
    );
  }

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool ShowReportsList = false;
  int _tabIndex = 2;

  int get tabIndex => _tabIndex;

  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  @override
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> appSettings;

  void initState() {
    // TODO: implement initState
    super.initState();
    Api.getLatestVersion(context).then((value) => {
          if (Globals.AppLatestVer > Globals.AppVer)
            {
              if (Globals.AllowOldversion == true)
                {
                  ShowVersionDialog(
                      "App Latest Version Found. Kindly Update", true, context)
                }
              else
                {
                  ShowVersionDialog(
                      "App Latest Version Found. Could not continue without update",
                      false,
                      context)
                }
            }
        });

    appSettings = _prefs.then((SharedPreferences prefs) {
      setState(() {
        bool tamEnabled = prefs.getBool('TamilEnabled') ?? false;
        if (tamEnabled == true) {
          gFontName = prefs.getString('FontName') ?? "Roboto";
        }
      });
      return prefs.getString('FontName') ?? "Roboto";
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final value = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Are you sure you want to exit finacc?'),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    ElevatedButton(
                      child: Text('Yes, exit'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                );
              });

          return value == true;
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(32)),
              ),
              elevation: 4,
              leading: Builder(
                  builder: (context) => IconButton(
                        icon: Icon(
                          MyFlutterApp.align_right,
                          color: Colors.blue,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      )),

              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications),
                  color: Colors.blue,
                ),
                // IconButton(onPressed: (){}, icon:Icon(Icons.more_vert),color: Colors.blue)
              ],
              flexibleSpace: SafeArea(
                  child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/FinAcc.ico",
                      height: 35,
                      width: 35,
                      matchTextDirection: true,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("FinAcc",
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
              )),
              // bottom: PreferredSize(
              //     child: Container(
              //       child: Text(
              //         "Hi",
              //         textAlign: TextAlign.left,
              //         style: TextStyle(color: Colors.brown, fontSize: 25),
              //       ),
              //       width: double.infinity,
              //       height: 50,
              //       color: Colors.yellow,
              //     ),
              //     preferredSize: Size.fromHeight(35.0))
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.green,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Live",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          // Text("Demo Version")
                        ],
                      ),
                    ),

                    //BalanceCard(),
                    StatusCard(),
                    ReportsLinkCard(),
                    RecentTransactions()
                  ],
                ),
              ),
            ),
            drawer: SafeArea(
                child: Drawer(
                    width: 250,
                    elevation: 1.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            //margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              //border: Border.all(color: Colors.green, width: 1),
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4 * 1),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 30.0),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/FinAcc.ico",
                                      width: 30,
                                      height: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      Globals.ClientInfo[0].Client_Name.length >
                                              16
                                          ? Globals.ClientInfo[0].Client_Name
                                                  .substring(0, 16) +
                                              "..."
                                          : Globals.ClientInfo[0].Client_Name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(Globals.Comp_Name),
                                Text(Globals.ClientInfo[0].Client_Code),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(height: 1),
                        ListTile(
                          title: Text("Change Company"),
                          leading: Icon(Icons.domain),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              // or pushReplacement, if you need that
                              context,
                              FadeInRoute(
                                routeName: "/companies",
                                page: Companies(),
                              ),
                            );

                            //Navigator.pushNamed(context, "/companies");
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(height: 1),
                        ListTile(
                            title: Text("Set / Change Pin"),
                            leading: Icon(Icons.key),
                            onTap: () {
                              Navigator.push(
                                // or pushReplacement, if you need that
                                context,
                                FadeInRoute(
                                  routeName: "/pingeneration",
                                  page: PinGeneration(),
                                ),
                              );

                              //Navigator.pushNamed(context, "/pingeneration");
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => const TestShared()),
                              //   );
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(height: 1),
                        ListTile(
                            title: Text("Settings"),
                            leading: Icon(Icons.settings),
                            onTap: () {
                              Navigator.push(
                                // or pushReplacement, if you need that
                                context,
                                FadeInRoute(
                                  routeName: "/appsettings",
                                  page: AppSettings(),
                                ),
                              );

                              //Navigator.pushNamed(context, "/pingeneration");
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => const TestShared()),
                              //   );
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          title: Text("Feedback"),
                          leading: Icon(Icons.feed),
                        ),
                        Divider(height: 1),
                        ListTile(
                            title: Text("Logout"),
                            leading: Icon(Icons.logout),
                            trailing: Text(
                              "Ver" + Globals.AppVer.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                            onTap: () {
                              showAlertDialog(context);
                            }),
                        Divider(height: 1),
                        SizedBox(
                          height: 30,
                        ),
                        Text("FinAcc Technologies"),
                        Text("www.finacc.in")
                      ],
                    ))),
            bottomNavigationBar: CircleNavBar(
              onTap: (index) {
                tabIndex = index;
                ShowReportsList = false;
                switch (index) {
                  case 0:
                    Navigator.push(
                      // or pushReplacement, if you need that
                      context,
                      FadeInRoute(
                        routeName: "/loanhistory",
                        page: LoanHistory(),
                      ),
                    );
                    break;

                  case 1:
                    Navigator.push(
                      // or pushReplacement, if you need that
                      context,
                      FadeInRoute(
                        routeName: "/repledgelist",
                        page: RepledgeList(),
                      ),
                    );
                    break;

                  case 3:
                    Navigator.push(
                      // or pushReplacement, if you need that
                      context,
                      FadeInRoute(
                        routeName: "/receiptslist",
                        page: ReceiptsList(),
                      ),
                    );
                    break;

                  case 4:
                    setState(() {
                      ShowReportsList = !ShowReportsList;
                    });
                    break;
                  // Navigator.pushNamed(context, "/adminaccounts");
                }
                // pageController.jumpToPage(tabIndex);
              },
              activeIcons: const [
                Icon(MyFlutterApp.hand_holding_usd, color: Color(0xffC87630)),
                Icon(Icons.repeat, color: Color(0xffC87630)),
                Icon(Icons.home, color: Color(0xffC87630)),
                Icon(
                  Icons.receipt,
                  color: Color(0xffC87630),
                ),
                Icon(Icons.bar_chart, color: Colors.green),
              ],
              inactiveIcons: [
                Icon(MyFlutterApp.hand_holding_usd, color: Colors.green),
                Icon(Icons.repeat, color: Colors.green),
                Icon(Icons.home, color: Colors.green),
                Icon(
                  Icons.receipt,
                  color: Color(0xffC87630),
                ),
                Icon(Icons.bar_chart, color: Colors.green),
              ],
              color: Colors.white,
              height: 60,
              circleWidth: 60,
              activeIndex: tabIndex,
              padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
              cornerRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              shadowColor: Colors.orange,
              elevation: 4,
            ),
            persistentFooterButtons: [
              (ShowReportsList == true)
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //borderRadius: BorderRadius.only(topRight: Radius.circular(84)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.blueGrey,
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "MIS Reports",
                            style: TextStyle(color: Colors.deepOrangeAccent),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            height: 20,
                            thickness: 2,
                          ),
                          Row(
                            children: [
                              IconButton(
                                iconSize: 35,
                                icon: Icon(
                                  Icons.analytics,
                                  color: Colors.green,
                                ),
                                onPressed: null,
                              ),
                              Text(
                                "Market Value Analysis",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "(Coming Soon)",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 10),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                iconSize: 35,
                                icon: Icon(
                                  Icons.equalizer,
                                  color: Colors.green,
                                ),
                                onPressed: null,
                              ),
                              Text(
                                "Business Register",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "(Coming Soon)",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 10),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                iconSize: 35,
                                icon: Icon(
                                  Icons.warehouse,
                                  color: Colors.green,
                                ),
                                onPressed: null,
                              ),
                              Text(
                                "Business Status",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "(Coming Soon)",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Text("")
            ],
          ),
        ));
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    child: Text("No"),
    onPressed: () {
      Navigator.of(context).pop();
      return;
    },
  );
  Widget continueButton = ElevatedButton(
    child: Text("Yes"),
    onPressed: () {
      Globals.IsLoggedIn = false;
      Globals.UserSno = 0;
      Globals.LoggedUser = "";
      // exit(0);
      Navigator.push(
        // or pushReplacement, if you need that
        context,
        FadeInRoute(
          routeName: "/",
          page: Login(),
        ),
      );
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Logoff"),
    content: Text("Are you sure you want to Exit?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

ShowVersionDialog(String Msg, bool AllowContinue, BuildContext context) {
  Widget continueButton = ElevatedButton(
    child: AllowContinue ? Text("Continue") : Text("Exit"),
    onPressed: () {
      if (AllowContinue == true) {
        Navigator.of(context).pop();
        //Navigator.pushNamed(context, Route);
      } else {
        exit(0);
        //Navigator.of(context).pop();
        // Navigator.pushReplacementNamed(context, route);
        //Navigator.pushNamed(context, route);
      }
      return;
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(Globals.AppName),
    content: Text(Msg),
    actions: [
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
