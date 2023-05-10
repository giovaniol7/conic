import 'package:brasil_fields/brasil_fields.dart';
import 'package:conic/repositorio/cliente_repositorio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:conic/widgets/campoTexto.dart';
import '../widgets/mensagem.dart';

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
  Widget build(BuildContext context) {
    void verificarSenhas() {
      if (txtEmail.text.isNotEmpty &&
          txtNome.text.isNotEmpty &&
          txtTelefone.text.isNotEmpty &&
          txtTelefoneSecundario.text.isNotEmpty
      ) {
        if (txtEmail.text.contains('@')) {
          if (txtSenha.text != txtSenhaCofirmar.text) {
            erro(context, 'Senhas não coincidem.');
          } else {
            if (txtSenha.text.length >= 4 || txtSenha.text.isEmpty){
              ClienteRepositorio CR = new ClienteRepositorio();
              CR.Post(txtNome.text, txtEmail.text, txtSenha.text,
                  txtTelefone.text, txtTelefoneSecundario.text);
              sucesso(context, 'Usuário atualizado.');
              Navigator.pop(context);
            }else{
              erro(context, 'Senha deve possuir mais de 4 caracteres.');
            }
          }
        }else{
          erro(context, 'Formato de e-mail inválido.');
        }
      } else {
        erro(context, 'Preencha corretamente todos os campos.');
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
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
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text('Criar'),
                        onPressed: () {
                          verificarSenhas();
                          Navigator.pop(context);
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
