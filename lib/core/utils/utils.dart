import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  Ref? ref;

  void toast(String msg, {BuildContext? context}) {
    Fluttertoast.showToast(msg: msg);
  }

  void pop(context) {
    Navigator.of(context).pop();
  }

  void router(context, widget) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  void routeReplace(context, widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  void routePopUntil(context, widget) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => widget),
        (Route<dynamic> route) => false);
  }

  showLoader(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              content: Row(
                children: const <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 50,
                  ),
                  Text("Please wait ...."),
                ],
              ),
            ));
  }

  dismissLoader(context) {
    Navigator.of(context).pop();
  }
}
