import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ushop/controllers/principal_requests.dart';
import 'package:ushop/database/database_user.dart';
import 'package:ushop/models/categorias.dart';
import 'package:ushop/screens/home.dart';
import 'package:ushop/screens/widgets/url.dart';

Future<List<Categoria>> fetchCategoriasFromDatabase() async {
  var dbHelper = DatabaseHelper();
  Future<List<Categoria>> categorias = dbHelper.fetchCategorias();
  return categorias;
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  RestPrincipalRequest api2 = new RestPrincipalRequest();
  String ip;

  getData() async {
    var cat = await fetchCategoriasFromDatabase();
    print(cat.isEmpty);
    if (cat.isEmpty) {
      await installPrincipales();
    }
  }

  installPrincipales() async {
    await Firestore.instance.collection('url').document('1').get().then((res)=> ip = res.data['url']);
    print(ip);
    await api2.infoNecesaria('http://${ip}:8080');
    
    print("Se realizo con exito");
  }

  @override
  initState() {
    
    getData();
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
              if (currentUser == null)
                {Navigator.pushReplacementNamed(context, "/login")}
              else
                {
                  Firestore.instance
                      .collection("users")
                      .document(currentUser.uid)
                      .get()
                      .then((DocumentSnapshot result) =>
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Publicaciones(
                                        uid: currentUser.uid,
                                        celular: result["celular"],
                                      ))))
                      .catchError((err) => print(err))
                }
            })
        .catchError((err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}
