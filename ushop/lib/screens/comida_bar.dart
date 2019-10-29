import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ushop/screens/widgets/buildCard.dart';

class DetallePage extends StatelessWidget {
  final String categoria, celular;
  const DetallePage({Key key, this.categoria, this.celular}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: Center(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection(categoria).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  List<DocumentSnapshot> dato = snapshot.data.documents;
                  return new GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 8.0 / 9.0,
                    ),
                    itemCount: dato.length,
                    padding: EdgeInsets.all(1.0),
                    itemBuilder: (BuildContext context, int index) {
                      return buildCard2(
                          context,
                          categoria,
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
    );
  }
}
