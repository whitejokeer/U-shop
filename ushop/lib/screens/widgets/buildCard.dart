import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ushop/screens/detallePublicacion.dart';
import 'package:ushop/screens/widgets/errorPopUP.dart';

Widget buildCard(
    BuildContext context,
    String uid,
    String pid,
    String categoria,
    String imagen,
    String precio,
    String nombre,
    String descripcion,
    String celular) {
  final ThemeData theme = Theme.of(context);
  return Padding(
    padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetallePublicacion(
                categoria: categoria,
                imagen: imagen,
                precio: precio,
                nombre: nombre,
                descripcion: descripcion,
                celular: celular),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: <Widget>[
                  Image.network(
                    imagen,
                    fit: BoxFit.fitWidth,
                  ),
                  IconButton(
                    iconSize: 50.0,
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await Firestore.instance
                          .collection(categoria)
                          .document(pid)
                          .delete()
                          .then((v) async {
                        await Firestore.instance
                            .collection('users')
                            .document(uid)
                            .collection('Publicaciones')
                            .document(pid)
                            .delete()
                            .then((onValue) {
                          errorAlert(context, "Se elimino con exito");
                        });
                      });
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      nombre,
                      style: theme.textTheme.button,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '\$${precio}',
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildCard2(BuildContext context, String categoria, String imagen,
    String precio, String nombre, String descripcion, String celular) {
  final ThemeData theme = Theme.of(context);
  return Padding(
    padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetallePublicacion(
                categoria: categoria,
                imagen: imagen,
                precio: precio,
                nombre: nombre,
                descripcion: descripcion,
                celular: celular),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.network(
                imagen,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      nombre,
                      style: theme.textTheme.button,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '\$${precio}',
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
