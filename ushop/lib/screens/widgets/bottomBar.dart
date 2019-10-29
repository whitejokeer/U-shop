import 'package:flutter/material.dart';

Widget bottomBar(BuildContext context, int caso) {
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
                    color: Color(0xFFEF7532),
                  ),
                  onPressed: () => caso != 1
                      ? Navigator.of(context).pushNamed('/home')
                      : null,
                ),
                IconButton(
                  icon: Icon(
                    Icons.shopping_basket,
                    color: Color(0xFF676E79),
                  ),
                  onPressed: () => caso != 2
                      ? Navigator.of(context).pushNamed('/publicaciones')
                      : null,
                )
              ],
            ),
          ),
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width / 2 - 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(icon: Icon(Icons.search, color: Color(0xFF676E79))),
                IconButton(
                  icon: Icon(Icons.person_outline, color: Color(0xFF676E79)),
                  // onPressed: () => caso != 4
                  //     ? Navigator.of(context).pushNamed('/perfil')
                  //     : null,
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
