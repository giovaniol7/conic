import 'package:brasil_fields/brasil_fields.dart';
import 'package:conic/model/cliente.dart';
import 'package:conic/repositorio/cliente_repositorio.dart';
import 'package:conic/widgets/campoTexto.dart';
import 'package:flutter/material.dart';
import 'package:conic/widgets/mensagem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class TelaPerfil extends StatefulWidget {
  final int? id;

  const TelaPerfil({Key? key, required this.id}) : super(key: key);

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtTelefone = TextEditingController();
  var txtTelefoneSecundario = TextEditingController();
  var txtSenhaCofirmar = TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;

  @override
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperarClienteID(widget.id);
  }

  void verificarSenhas() {
    if (txtEmail.text.isNotEmpty &&
        txtNome.text.isNotEmpty &&
        txtTelefone.text.isNotEmpty &&
        txtTelefoneSecundario.text.isNotEmpty
    ) {
      if (txtEmail.text.contains('@')) {
        if (txtSenha.text.isNotEmpty) {
          if (txtSenha.text != txtSenhaCofirmar.text) {
            erro(context, 'Senhas não coincidem.');
          } else {
            if (txtSenha.text.length >= 4 || txtSenha.text.isEmpty) {
              ClienteRepositorio CR = new ClienteRepositorio();
              CR.Put(widget.id, txtNome.text, txtEmail.text, txtSenha.text,
                  txtTelefone.text, txtTelefoneSecundario.text);
              sucesso(context, 'Usuário atualizado.');
              Navigator.pop(context);
            } else {
              erro(context, 'Senha deve possuir mais de 4 caracteres.');
            }
          }
        } else {
          erro(context, 'Coloque a senha.');
        }
      }else{
        erro(context, 'Formato de e-mail inválido.');
      }
    } else {
      erro(context, 'Preencha corretamente todos os campos.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Atualizar Usuário",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey.shade300,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade100),
        padding: EdgeInsets.all(16),
        child: Center(
          child: ListView(
            children: [
              campoTexto('Nome Completo', txtNome, Icons.people),
              const SizedBox(height: 20),
              campoTexto('Email', txtEmail, Icons.email),
              const SizedBox(height: 20),
              campoTexto('Telefone', txtTelefone, Icons.phone,
                  formato: TelefoneInputFormatter(), numeros: true),
              const SizedBox(height: 20),
              campoTexto(
                  'Telefone Secundário', txtTelefoneSecundario, Icons.phone,
                  formato: TelefoneInputFormatter(), numeros: true),
              const SizedBox(height: 20),
              campoTexto('Senha', txtSenha, Icons.lock,
                  sufIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: _toggle,
                  ),
                  senha: _obscureText),
              const SizedBox(height: 20),
              campoTexto('Confirmar Senha', txtSenhaCofirmar, Icons.lock,
                  sufIcon: IconButton(
                    icon: Icon(
                      _obscureText2 ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: _toggle2,
                  ),
                  senha: _obscureText2),
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
                        backgroundColor: Colors.indigo,
                        elevation: 5,
                      ),
                      child: const Text(
                        'Criar',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        verificarSenhas();
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  SizedBox(
                    width: 150,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: const Size(200, 45),
                        backgroundColor: Colors.red,
                        elevation: 5,
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(fontSize: 18),
                      ),
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

  recuperarClienteID(idd) async {
    ClienteRepositorio CR = ClienteRepositorio();
    Cliente c = await CR.recuperarClienteId(idd);
    var id = c.id;
    txtNome.text = c.nome!;
    txtEmail.text = c.email!;
    txtTelefone.text = c.telefone1!;
    txtTelefoneSecundario.text = c.telefone2!;
  }
}
