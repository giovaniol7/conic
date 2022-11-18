import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:conic/model/dispositivo.dart';
import 'package:http/http.dart' as http;

class DispositivoRepositorio {
  String urlBase = "https://gas-sensor-api.herokuapp.com/api";

  Future<List> recuperarDispositivo() async {
    http.Response response = await http.get(Uri.parse("$urlBase/device/2"));

    if (response.statusCode == 200) {
      var dadosJson = json.decode(response.body);
      return dadosJson.map((json) => Dispositivo.fromJson(json)).toList();
    } else {
      throw Exception('Erro não foi possivel carregar usuarios');
    }
  }

  Post(idCli, nome, mac) async {
    Dispositivo d = Dispositivo (null, idCli, nome, mac, 0);

    var corpo = json.encode(d.toJson());

    http.Response response = await http.post(Uri.parse("$urlBase/device/2"),
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  Put(id, idCli, nome, mac) async {
    Dispositivo d = new Dispositivo(null, idCli, nome, mac, 0);

    var corpo = json.encode(d.toJson());

    http.Response response = await http.put(Uri.parse("$urlBase/device/"),
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

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
