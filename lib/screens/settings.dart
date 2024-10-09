import 'dart:async';

import 'package:finacc/config/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  static const String routeName = '/appsettings';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => AppSettings(),
    );
  }

  @override
  State<AppSettings> createState() => _SettingsState();
}

class _SettingsState extends State<AppSettings> {
  @override
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> appSettings;
  late String FontName = "";
  late bool TamilEnabled = false;
  bool loading = true;
  bool onLoad = true;

  String ToastMsg = "";
  bool errorFont = false;

  TextEditingController fontController = new TextEditingController();

  Future<void> _UpdateSettings(String NewFontName) async {
    final SharedPreferences prefs = await _prefs;
    //final int Pin = (prefs.getInt('Pin') ?? 0) + 1;
    setState(() {
      appSettings =
          prefs.setString('FontName', NewFontName).then((bool success) {
        prefs.setBool('TamilEnabled', TamilEnabled);
        prefs.setString('FontName', NewFontName);
        gFontName = NewFontName;
        return appSettings;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appSettings = _prefs.then((SharedPreferences prefs) {
      TamilEnabled = prefs.getBool('TamilEnabled') ?? false;
      FontName = prefs.getString('FontName') ?? "";

      setState(() {
        loading = false;
        fontController.text = FontName;
      });
      return prefs.getString('FontName') ?? "Roboto";
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.white, //background color of app bar
        foregroundColor: Colors.deepOrangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32)),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Tamil Enabled",
                  style: TextStyle(fontSize: 16),
                ),
                Checkbox(
                    value: this.TamilEnabled,
                    onChanged: (value) {
                      setState(() {
                        this.TamilEnabled = value!;
                      });
                    }),
              ],
            ),
            Text(
                "Type a Valid Tamil font Name here which is supported by FinAcc. To check the supported FinAcc Tamil fonts visit FinAcc Official Website www.finacc.in "),
            TextFormField(
              maxLength: 20,
              // keyboardType: TextInputType.number,
              controller: fontController,

              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffC87630),
                    ),
                  ),
                  hintText: "Enter Tamil Font Name",
                  hintStyle: TextStyle(color: Color(0xffC87630))),
            ),
            SizedBox.fromSize(
              size: Size(200, 56),
              child: ClipRect(
                child: Material(
                  color: Colors.orange,
                  child: InkWell(
                    splashColor: Colors.green,
                    onTap: () {
                      // if (fontController.text.length < 4)
                      // {
                      //   setState(() {
                      //     errorFont = true;
                      //   });
                      //
                      // }
                      // else
                      // {
                      errorFont = false;
                      _UpdateSettings(fontController.text).then((value) => {
                            ToastMsg = "Settings updated Sucessfully",
                            Timer(
                                Duration(seconds: 1),
                                () => Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Dashboard();
                                    })))
                          });

                      // }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.save,
                          color: Colors.white,
                        ), // <-- Icon
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Update Settings",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ), // <-- Text
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
