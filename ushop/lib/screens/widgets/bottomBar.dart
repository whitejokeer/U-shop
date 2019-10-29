import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ushop/screens/home.dart';
import 'package:ushop/screens/misPublicaciones.dart';
import 'package:ushop/screens/salir.dart';

Widget bottomBar(BuildContext context, int caso, String uid, String celular) {
  return BottomAppBar(
    shape: CircularNotchedRectangle(),
    notchMargin: 6.0,
    color: Colors.transparent,
    elevation: 9.0,
    clipBehavior: Clip.antiAlias,
    child: Container(
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width / 2 - 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.home,
                      color: caso != 1 ? Color(0xFF676E79) : Color(0xFFEF7532),
                    ),
                    onPressed: () async {
                      final FirebaseUser user =
                          await FirebaseAuth.instance.currentUser();
                      caso != 1
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Publicaciones(
                                        uid: user.uid,
                                        celular: celular,
                                      )))
                          : null;
                    }),
                IconButton(
                    icon: Icon(
                      Icons.shopping_basket,
                      color: caso != 2 ? Color(0xFF676E79) : Color(0xFFEF7532),
                    ),
                    onPressed: () async {
                      final FirebaseUser user =
                          await FirebaseAuth.instance.currentUser();
                      caso != 2
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MisPublicaciones(
                                  uid: user.uid,
                                  celular: celular,
                                ),
                              ),
                            )
                          : null;
                    })
              ],
            ),
          ),
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width / 2 - 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.search,
                        color:
                            caso != 3 ? Color(0xFF676E79) : Color(0xFFEF7532))),
                IconButton(
                  icon: Icon(
                    Icons.person_outline,
                    color: caso != 4 ? Color(0xFF676E79) : Color(0xFFEF7532),
                  ),
                  onPressed: () => caso != 2
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Salir()),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
