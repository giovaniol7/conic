import 'dart:convert';
import 'package:conic/model/dispositivo.dart';
import 'package:http/http.dart' as http;

class DispositivoRepositorio {

  String urlBase = "https://gas-sensor-api.herokuapp.com/api";

  Future<List<Dispositivo>> recuperarDispositivo() async {

    http.Response response = await http.get(Uri.parse("$urlBase/device/"));
    var dadosJson = json.decode( response.body );

    List<Dispositivo> dispositivos = [];
    for( var Dispositivo in dadosJson ){
      print("Dispositivo: " + Dispositivo["nome"] );
      Dispositivo d = Dispositivo(Dispositivo["id"], Dispositivo["idCliente"], Dispositivo["nome"], Dispositivo["mac"], Dispositivo["lock"]);
      dispositivos.add(d);
    }
    return dispositivos;
  }

  Post(idCli, nome, mac) async {

    Dispositivo d = Dispositivo(null, idCli, nome, mac, 0);

    var corpo = json.encode(
        d.toJson()
    );

    http.Response response = await http.post(
        Uri.parse("$urlBase/device/"),
        headers: {
          "Content-type": "application/json; charset=UTF-8"
        },
        body: corpo
    );

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");

  }

  Put(id, idCli, nome, mac) async {

    Dispositivo d = new Dispositivo(id, idCli, nome, mac, 0);

    var corpo = json.encode(
        d.toJson()
    );

    http.Response response = await http.put(
        Uri.parse("$urlBase/device/"),
        headers: {
          "Content-type": "application/json; charset=UTF-8"
        },
        body: corpo
    );

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");

  }

  Delete() async {

    http.Response response = await http.delete(
      Uri.parse("$urlBase/device/"),
    );

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");

  }
}