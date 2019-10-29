import 'package:flutter/material.dart';
import 'colors.dart';

Widget generalAppBar(BuildContext context, String titulo, bool principal) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0.0,
    centerTitle: true,
    leading: principal
        ? Image.asset(
            "assets/diamond.png",
            scale: 4.0,
          )
        : IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: grisAppbar,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
    title: Text(
      titulo,
      style: TextStyle(fontFamily: 'Varela', fontSize: 20.0, color: grisAppbar),
    ),
  );
}
