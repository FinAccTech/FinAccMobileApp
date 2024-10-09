import 'dart:io';
import 'package:finacc/config/globals.dart' as Globals;
import 'package:finacc/config/api.dart';
import 'package:finacc/config/customicons.dart';
import 'package:finacc/widgets/msgbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => Login(),
    );
  }

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool hidePassword = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // usernameController = new TextEditingController(text: '9994484558');
    // passwordController = new TextEditingController(text: 'finacc@123');
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
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
                color: Colors.orange),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    //padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.yellow,
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 500),
                      ],
                    ),
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
                    height: 100,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: kIsWeb
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        launch(
                                            "https://finacc.in/Downloads/FinAcc.apk");
                                      },
                                      icon: Icon(
                                        Icons.android,
                                        color: Colors.white,
                                      )),
                                  Text(
                                    "Download APK",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )
                            : Text(""),
                      )),
                  Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Enter your Cloud Login credentials",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        TextFormField(
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Mobile Number";
                            } else {
                              if (value.length < 10) {
                                return "Enter Valid Mobile Number";
                              }
                            }
                          },
                          controller: usernameController,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffC87630),
                                ),
                              ),
                              icon: Icon(
                                Icons.phone,
                                color: Color(0xffC87630),
                              ),
                              hintText: "Mobile Number",
                              hintStyle: TextStyle(color: Color(0xffC87630))),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          maxLength: 12,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Password";
                            }
                          },
                          obscureText: hidePassword,
                          style: TextStyle(color: Color(0xffC87630)),
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
                              hintText: "Password",
                              hintStyle: TextStyle(color: Color(0xffC87630))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            //forgot password screen
                          },
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(color: Color(0xffC87630)),
                          ),
                        ),
                        SizedBox(
                            width: double.infinity, // <-- match_parent
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.orange),
                                onPressed: () {
                                  // if (validateForm()) {
                                  Api.getUser(
                                          usernameController.text.toString(),
                                          passwordController.text.toString(),
                                          context)
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
                                  // }
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.login),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("LOGIN")
                                    ],
                                  ),
                                ))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
