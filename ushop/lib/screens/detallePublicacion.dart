import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ushop/screens/widgets/appBar.dart';
import 'package:ushop/screens/widgets/bottomBar.dart';
import 'package:ushop/screens/widgets/floatingButton.dart';

class DetallePublicacion extends StatelessWidget {
  final String categoria, imagen, precio, nombre, descripcion, celular;
  const DetallePublicacion(
      {Key key,
      this.categoria,
      this.imagen,
      this.precio,
      this.nombre,
      this.descripcion,
      this.celular})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context, "", false),
      body: ListView(
        children: [
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(categoria,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 42.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF17532))),
          ),
          SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:15.0),
            child: AspectRatio(
              
                  aspectRatio: 18 / 11,
                  child: Image.network(
                    imagen,
                    height: 150.0, width: 100.0,                  
                    fit: BoxFit.fitWidth,
                  ),
                ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: Text('\$${precio}',
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF17532))),
          ),
          SizedBox(height: 10.0),
          Center(
            child: Text(nombre,
                style: TextStyle(
                    color: Color(0xFF575E67),
                    fontFamily: 'Varela',
                    fontSize: 24.0)),
          ),
          SizedBox(height: 20.0),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(descripcion,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      color: Color(0xFFB4B8B9))),
            ),
          ),
          SizedBox(height: 20.0),
          MaterialButton(
            onPressed: ()=>launch('whatsapp://send?phone=$celular'),
            padding: EdgeInsets.all(0.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(0xFFF17532)),
                child: Center(
                  child: Text(
                    'Contactar',
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomBar(context, 0),
    );
  }
}
