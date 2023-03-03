import 'dart:convert';
import 'package:conic/model/cliente.dart';
import 'package:http/http.dart' as http;

class ClienteRepositorio {

  String urlBase = "https://apigas.onrender.com/api";

  Future<List> recuperarCliente() async {
    http.Response response = await http.get(Uri.parse("$urlBase/admin/cliente/"));

    if (response.statusCode == 200) {
      var dadosJson = json.decode(response.body);
      return dadosJson.map((json) => Cliente.fromJson(json)).toList();
    } else {
      throw Exception('Erro não foi possivel carregar usuarios');
    }
  }

  Future<Cliente> recuperarClienteLogin(email, senha) async {
    http.Response response = await http.get(Uri.parse("$urlBase/cliente/${email}/${senha}"));
    var dadosJson = json.decode(response.body);
    Cliente c = Cliente(null, '', '', '', '', '');
    if (response.statusCode == 200) {
      c.email = dadosJson["email"];
      c.senha = dadosJson["senha"];
      c.id = dadosJson["id"];
      c.nome = dadosJson["nome"];
      c.telefone1 = dadosJson["telefone1"];
      c.telefone2 = dadosJson["telefone2"];
      return c;
    } else {
      throw Exception('Erro não foi possivel carregar usuario');
    }
  }

  Future<Cliente> recuperarClienteId(id) async {
    http.Response response = await http.get(Uri.parse("$urlBase/cliente/${id}"));
    var dadosJson = json.decode(response.body);
    Cliente c = Cliente(null, '', '', '', '', '');
    if (response.statusCode == 200) {
      c.email = dadosJson["email"];
      c.senha = dadosJson["senha"];
      c.id = dadosJson["id"];
      c.nome = dadosJson["nome"];
      c.telefone1 = dadosJson["telefone1"];
      c.telefone2 = dadosJson["telefone2"];
      return c;
    } else {
      throw Exception('Erro não foi possivel carregar usuario');
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