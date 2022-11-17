import 'dart:convert';
import 'package:conic/model/cliente.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ClienteRepositorio {

  String urlBase = "https://gas-sensor-api.herokuapp.com/api";

  Future<List<Cliente>> recuperarCliente() async {

    http.Response response = await http.get(Uri.parse("$urlBase/cliente/"));
    var dadosJson = json.decode(response.body);

    List<Cliente> clientes = [];
    for( var Cliente in dadosJson ){
      print("Cliente: " + Cliente["nome"] );
      Cliente c = Cliente(Cliente["id"], Cliente["nome"], Cliente["email"], Cliente["senha"], Cliente["telefone1"], Cliente["telefone2"]);
      clientes.add(c);
    }
    return clientes;
  }

  Future<Cliente> recuperarClienteLogin(email, senha) async {

    http.Response response = await http.get(Uri.parse("$urlBase/cliente/"));
    var dadosJson = json.decode(response.body);
    Cliente c = Cliente(null, "", "", "", "", "");
    for(var Cliente in dadosJson){
      if (Cliente.email == email && Cliente.senha == senha){
        c.id = Cliente.id;
        c.email = Cliente.email;
        c.senha = Cliente.senha;
      }
    }
    return c;
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