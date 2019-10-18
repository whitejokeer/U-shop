import 'package:flutter/material.dart';

Future<void> errorAlert(BuildContext context, String error) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text("Ups"),),
        content: Text(error),
        actions: <Widget>[
          FlatButton(
            child: Text("Volver"),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
