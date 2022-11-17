import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:conic/model/dispositivo.dart';
import 'package:http/http.dart' as http;

class DispositivoRepositorio {
  String urlBase = "https://gas-sensor-api.herokuapp.com/api";

  Future<List<Dispositivo>> recuperarDispositivo() async {
    http.Response response = await http.get(Uri.parse("$urlBase/device/"));
    var dadosJson = json.decode(response.body);

    List<Dispositivo> dispositivos = [];
    for (var Dispositivo in dadosJson) {
      print("Dispositivo: " + Dispositivo["nome"]);
      Dispositivo d = Dispositivo (id: Dispositivo["id"], idCliente: Dispositivo["idCliente"],
          nome: Dispositivo["nome"], mac: Dispositivo["mac"], lock: Dispositivo["lock"]);
      dispositivos.add(d);
    }
    return dispositivos;
  }

  Future<List<Dispositivo>?> recuperarDispositivoCliente() async {
    try {
      var response = await http.get(Uri.parse("$urlBase/device/"));
      if (response.statusCode == 200) {
        List<Dispositivo> model = userModelFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Post(idCli, nome, mac) async {
    Dispositivo d = Dispositivo (id: null, idCliente: idCli, nome: nome, mac: mac, lock: 0);

    var corpo = json.encode(d.toJson());

    http.Response response = await http.post(Uri.parse("$urlBase/device/"),
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  Put(id, idCli, nome, mac) async {
    Dispositivo d = new Dispositivo(id: null, idCliente: idCli, nome: nome, mac: mac, lock: 0);

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
