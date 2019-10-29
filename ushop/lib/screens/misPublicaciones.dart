import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ushop/screens/widgets/appBar.dart';
import 'package:ushop/screens/widgets/bottomBar.dart';
import 'package:ushop/screens/widgets/buildCard.dart';
import 'package:ushop/screens/widgets/floatingButton.dart';

class MisPublicaciones extends StatefulWidget {
  final String uid, celular;

  MisPublicaciones({Key key, this.uid, this.celular}) : super(key: key);

  _MisPublicacionesState createState() => _MisPublicacionesState();
}

class _MisPublicacionesState extends State<MisPublicaciones>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context, "Publicaciones", false),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Text(
            "Mis Publicaciones",
            style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 42.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 50.0,
            width: double.infinity,
            child: Center(
              child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('users')
                      .document(widget.uid)
                      .collection("Publicaciones")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      default:
                        List<DocumentSnapshot> dato = snapshot.data.documents;
                        return new GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 8.0 / 9.0,
                          ),
                          itemCount: dato.length,
                          padding: EdgeInsets.all(1.0),
                          itemBuilder: (BuildContext context, int index) {
                            return buildCard(
                                context,
                                widget.uid,
                                dato[index].documentID,
                                dato[index]['categoria'],
                                dato[index]['imagen_publicacion'],
                                dato[index]['precio'],
                                dato[index]['nombre_publicacion'],
                                dato[index]['descripcion'],
                                dato[index]['celular']);
                          },
                        );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: floatingButton(context, widget.uid, widget.celular),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomBar(context, 2, widget.uid, widget.celular),
    );
  }
}
