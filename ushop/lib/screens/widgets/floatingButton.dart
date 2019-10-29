import 'package:flutter/material.dart';
import 'package:ushop/screens/addPublicacion.dart';

Widget floatingButton(BuildContext context,String uid, String celular) {
  return FloatingActionButton(
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPublicacion(
          uid: uid,
          celular: celular,
        ),
      ),
    ),
    backgroundColor: Color(0xFFF17532),
    child: Icon(Icons.library_add),
  );
}
