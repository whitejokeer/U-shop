import 'package:flutter/material.dart';
import 'package:ushop/screens/publicacion_bar.dart';
import 'package:ushop/screens/widgets/appBar.dart';
import 'package:ushop/screens/widgets/bottomBar.dart';
import 'package:ushop/screens/widgets/floatingButton.dart';

class Publicaciones extends StatefulWidget {
  final String uid, celular;

  Publicaciones({Key key, this.uid, this.celular}) : super(key: key);

  _PublicacionesState createState() => _PublicacionesState();
}

class _PublicacionesState extends State<Publicaciones>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    print(widget.celular);
    print(widget.uid);
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context, "Publicaciones", true),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Text(
            "Categorias",
            style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 42.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelColor: Color(0xFFC88D67),
            isScrollable: true,
            labelPadding: EdgeInsets.only(right: 45.0),
            unselectedLabelColor: Color(0xFFCDCDCD),
            tabs: [
              Tab(
                child: Text(
                  'Comida',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Tutorias',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Libros',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Transporte',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Otros',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height - 50.0,
            width: double.infinity,
            child: TabBarView(controller: _tabController, children: [
              DetallePage(categoria: "Comida", celular: widget.celular),
              DetallePage(categoria: "Tutorias", celular: widget.celular),
              DetallePage(categoria: "Libros", celular: widget.celular),
              DetallePage(categoria: "Transporte", celular: widget.celular),
              DetallePage(categoria: "Otros", celular: widget.celular),
            ]),
          ),
        ],
      ),
      floatingActionButton: floatingButton(context, widget.uid, widget.celular),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomBar(context, 1, widget.uid, widget.celular),
    );
  }
}
