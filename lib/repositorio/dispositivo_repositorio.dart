import 'dart:convert';
import 'package:conic/model/dispositivo.dart';
import 'package:http/http.dart' as http;

class DispositivoRepositorio {
  String urlBase = "https://gas-sensor-api.herokuapp.com/api";

  Future<List> recuperarDispositivo(int id) async {
    http.Response response = await http.get(Uri.parse("$urlBase/device/$id"));
    if (response.statusCode == 200) {
      var dadosJson = json.decode(response.body);
      return dadosJson.map((json) => Dispositivo.fromJson(json)).toList();
    } else {
      throw Exception('Erro não foi possivel carregar usuarios');
    }
  }

  Future<Dispositivo> recuperarDispositivoMAC(String MAC) async {
    http.Response response = await http.get(Uri.parse("$urlBase/device/address/$MAC"));
    var dadosJson = json.decode(response.body);
    Dispositivo d = Dispositivo(id: null, idCliente: null, nome: '', mac: '', lock: 0);
    if (response.statusCode == 200) {
      d.id = dadosJson["id"];
      d.idCliente = dadosJson["idCliente"];
      d.nome = dadosJson["nome"];
      d.mac = dadosJson["mac"];
      d.lock = dadosJson["lock"];
      return d;
    } else {
      throw Exception('Erro não foi possivel carregar usuario');
    }
  }

  Post(idCli, nome, mac) async {
    Dispositivo d = Dispositivo(id: null, idCliente: idCli, nome: nome, mac: mac, lock: 0);
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

  Put(id, idCli, nome, mac, lock) async {
    Dispositivo d = Dispositivo(id: id, idCliente: idCli, nome: nome, mac: mac, lock: lock);

    var corpo = json.encode(d.toJson());

    http.Response response = await http.put(Uri.parse("$urlBase/device/"),
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  Delete(int id) async {
    http.Response response = await http.delete(
      Uri.parse("$urlBase/device/$id"),
    );

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }
}
