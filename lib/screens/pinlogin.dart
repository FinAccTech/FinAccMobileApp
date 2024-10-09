import 'dart:io';
import 'package:finacc/config/globals.dart' as Globals;
import 'package:finacc/config/api.dart';
import 'package:finacc/config/customicons.dart';
import 'package:finacc/screens/login.dart';
import 'package:finacc/widgets/msgbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinLogin extends StatefulWidget {
  const PinLogin({Key? key}) : super(key: key);

  static const String routeName = '/pinlogin';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => PinLogin(),
    );
  }

  @override
  State<PinLogin> createState() => _PinLoginState();
}

class _PinLoginState extends State<PinLogin> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool hidePassword = true;
  bool ErrorPin = false;
  var _Loginpin;
  var _Username;
  var _Password;

  @override
  void initState() {
    super.initState();
    _prefs.then((value) => {
          _Loginpin = (value.get("Pin")),
          _Username = (value.get("User")),
          _Password = (value.get("Pwd")),
        });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.only(topLeft: Radius.circular(184),topRight: Radius.circular(184),bottomLeft: Radius.circular(184),bottomRight: Radius.circular(184)),
              borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(0, 0),
                  topLeft: Radius.elliptical(0, 0)),
            ),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.all(20),
                    // width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                            alignment: AlignmentDirectional.center,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 100,
                              ),
                              Column(
                                children: [
                                  Image.asset("assets/images/FinAcc.ico"),
                                  Text(
                                    "FinAcc",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontFamily: "Arial",
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ErrorPin
                      ? Text(
                          "Invalid Pin. Multiple attempts will block the App",
                          style: TextStyle(color: Colors.red),
                        )
                      : Text(""),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: TextFormField(
                      maxLength: 4,
                      style: TextStyle(color: Colors.grey, fontSize: 40),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      //controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Pin";
                        }
                      },
                      obscureText: hidePassword,
                      onChanged: (value) {
                        if (value.length == 4) {
                          if (value.toString() != _Loginpin.toString()) {
                            setState(() {
                              ErrorPin = true;
                            });
                          } else {
                            setState(() {
                              ErrorPin = false;
                            });
                            Api.getUser(_Username, _Password, context)
                                .then((value) => {
                                      if (value == false)
                                        {
                                          ShowMessageDialog(
                                              "Invalid Username or Password",
                                              "",
                                              context)
                                        }
                                      else
                                        {
                                          Navigator.pushReplacementNamed(
                                              context, "/dashboard")
                                        }
                                    });
                          }
                        }
                      },
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffC87630),
                            ),
                          ),
                          icon: Icon(Icons.lock, color: Color(0xffC87630)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: Icon(hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: Colors.black,
                          ),
                          hintText: "PIN",
                          hintStyle: TextStyle(color: Color(0xffC87630))),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: Text("Login with Username and Password"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
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
    builder: (BuildContext context) {
      return alert;
    },
  );
}
