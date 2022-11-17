import 'package:brasil_fields/brasil_fields.dart';
import 'package:conic/repositorio/cliente_repositorio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:conic/widgets/campoTexto.dart';
import '../widgets/mensagem.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class TelaCadastroUsuario extends StatefulWidget {
  const TelaCadastroUsuario({Key? key}) : super(key: key);
  @override
  State<TelaCadastroUsuario> createState() => _TelaCadastroUsuarioState();
}

class _TelaCadastroUsuarioState extends State<TelaCadastroUsuario> {

  TextEditingController txtNome = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();
  TextEditingController txtTelefone = TextEditingController();
  TextEditingController txtTelefoneSecundario = TextEditingController();
  TextEditingController txtSenhaCofirmar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void verificarSenhas(){
      if(txtSenha.text != txtSenhaCofirmar.text){
        erro(context, 'Senhas não coincidem.');
      }else{
        ClienteRepositorio CR = new ClienteRepositorio();
        CR.Post(txtNome.text, txtEmail.text, txtSenha.text, txtTelefone.text, txtTelefoneSecundario.text);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.grey.shade300,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: ListView(
              children: [
                campoTexto('Nome Completo', txtNome, Icons.people),
                const SizedBox(height: 20),
                campoTexto('Email', txtEmail, Icons.email),
                const SizedBox(height: 20),
                campoTexto('Telefone', txtTelefone, Icons.phone, formato: TelefoneInputFormatter(), numeros: true),
                const SizedBox(height: 20),
                campoTexto('Telefone Secundário', txtTelefoneSecundario, Icons.phone, formato: TelefoneInputFormatter(), numeros: true),
                const SizedBox(height: 20),
                campoTexto('Senha', txtSenha, Icons.lock, senha: true),
                const SizedBox(height: 20),
                campoTexto('Confirmar Senha', txtSenhaCofirmar, Icons.lock, senha: true),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: const Size(200, 45),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text('Criar'),
                        onPressed: () {
                          verificarSenhas();
                          //criarConta(txtNome.text, txtEmail.text, txtTelefone.text, txtSenha.text);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: const Size(200, 45),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
              ],
          ),
        ),
      ),
    );
  }
}
