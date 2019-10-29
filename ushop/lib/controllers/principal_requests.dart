import 'package:dio/dio.dart';
import 'package:ushop/database/database_user.dart';
import 'package:ushop/models/carreras.dart';
import 'package:ushop/models/categorias.dart';
import 'package:ushop/models/university.dart';
import 'package:ushop/screens/widgets/url.dart';

class RestPrincipalRequest {
  infoNecesaria() async {
    String urlPrincipal1 = urlPrincipal;
    Dio dio = new Dio();
    var dba = new DatabaseHelper();

    dio.options.baseUrl = urlPrincipal1; //url del servidor
    dio.options.connectTimeout = 5000; // 5 segundos
    dio.options.receiveTimeout = 5000; // 3 segundos

    await dba.deleteUniversidad();
    await dba.deleteCarreras();
    await dba.deleteCategorias();

    Response universidad =
        await dio.get("/universidades"); // configuracion del endpoint
    
    print("------------------------------------------------->");
    print(universidad.data);
    print("------------------------------------------------->");

    var universidadMap = universidad.data; // Accedemos al manejo del json retornado

    universidadMap.forEach((dataMap) async {
      final universidad = Universidad.map(dataMap);
      await dba.saveUniversidad(universidad);
    });

    Response carrera = await dio.get("/carreras");
    print("------------------------------------------------->");
    print(carrera.data);
    print("------------------------------------------------->");

    var carreraMap = carrera.data;

    carreraMap.forEach((dataMap) async {
      final carrera = Carrera.map(dataMap);
      await dba.saveCarrera(carrera);
    });

    Response categoria = await dio.get("/categorias");

    print("------------------------------------------------->");
    print(categoria.data);
    print("------------------------------------------------->");

    var categoriaMap = categoria.data;

    categoriaMap.forEach((dataMap) async {
      final categoria = Categoria.map(dataMap);
      await dba.saveCategoria(categoria);
    });

    print("Terminado");
  }
}
