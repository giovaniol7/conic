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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperarClienteID(widget.id);
  }

  void verificarSenhas(){
    if(txtSenha.text.isNotEmpty) {
      if(txtSenha.text != txtSenhaCofirmar.text){
        erro(context, 'Senhas não coincidem.');
      }else{
        ClienteRepositorio CR = new ClienteRepositorio();
        CR.Put(widget.id, txtNome.text, txtEmail.text, txtSenha.text, txtTelefone.text, txtTelefoneSecundario.text);
        sucesso(context, 'Usuário atualizado.');
        Navigator.pop(context);
      }
    }else{
      erro(context, 'Digite uma senha.');
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text("Atualizar Usuário", style: TextStyle(color: Colors.black),),
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
