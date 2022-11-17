import 'dart:convert';
import 'package:conic/model/dispositivo.dart';
import 'package:http/http.dart' as http;

class DispositivoRepositorio {
  String urlBase = "https://gas-sensor-api.herokuapp.com/api";

  Future<List<Dispositivo>> recuperarDispositivo() async {
    http.Response response = await http.get(Uri.parse("$urlBase/device/1"));

    if (response.statusCode == 200) {
      var dadosJson = json.decode(response.body);
      return dadosJson.map((json) => Dispositivo.fromJson(json)).toList();
    } else {
      throw Exception('Erro não foi possivel carregar usuarios');
    }
  }
}