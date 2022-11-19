import 'package:conic/model/cliente.dart';
import 'package:conic/repositorio/cliente_repositorio.dart';
import 'package:conic/view/TelaCadastroUsuario.dart';
import 'package:conic/view/TelaPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:conic/widgets/campoTexto.dart';
import '../widgets/mensagem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);
  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();
  var id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey.shade300,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade100),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "lib/imagens/slogam.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: campoTexto('Email', txtEmail, Icons.email),
                ),
                campoTexto('Senha', txtSenha, Icons.lock, senha: true),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      recuperarClienteLo(txtEmail.text, txtSenha.text);
                    },
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Não tem conta? Cadastre-se!",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaCadastroUsuario()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  recuperarClienteLo(email, senha) async {
    ClienteRepositorio CR = ClienteRepositorio();
    Cliente c = await CR.recuperarClienteLogin(email, senha);
    if (c.email == email && c.senha == senha) {
      var id = c.id;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => TelaPrincipal(id: c.id)));
      sucesso(context, "Usuário autenticado");
    } else {
      erro(context, "Email e Senha inválidos.");
    }
  }
}
