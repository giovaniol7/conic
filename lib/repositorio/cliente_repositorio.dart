import 'dart:convert';
import 'dart:developer';
import 'package:conic/model/cliente.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ClienteRepositorio {

  String urlBase = "https://gas-sensor-api.herokuapp.com/api";

  Future<List> recuperarCliente() async {
    http.Response response = await http.get(Uri.parse("$urlBase/admin/cliente/"));

    if (response.statusCode == 200) {
      var dadosJson = json.decode(response.body);
      return dadosJson.map((json) => Cliente.fromJson(json)).toList();
    } else {
      throw Exception('Erro não foi possivel carregar usuarios');
    }
  }

  Post(nome, email, senha, tel1, tel2) async {
    Cliente c = Cliente(null, nome, email, senha, tel1, tel2);
    var corpo = json.encode(
        c.toJson()
    );
    http.Response response = await http.post(
        Uri.parse("$urlBase/cliente/"),
        headers: {
          "Content-type": "application/json; charset=UTF-8"
        },
        body: corpo
    );
    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  Put(id, nome, email, senha, tel1, tel2) async {
    Cliente c = new Cliente(id, nome, email, senha, tel1, tel2);
    var corpo = json.encode(
        c.toJson()
    );
    http.Response response = await http.put(
        Uri.parse("$urlBase/cliente/"),
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
      Uri.parse("$urlBase/cliente/"),
    );
    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }
}