import 'package:flutter/material.dart';
import 'package:finacc/config/globals.dart' as Globals;

ShowMessageDialog(String Msg, String route, BuildContext context) {
  Widget continueButton = ElevatedButton(
    child: Text("OK"),
    onPressed: () {
      if (route == "") {
        Navigator.of(context).pop();
        //Navigator.pushNamed(context, Route);
      } else {
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, route);
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
