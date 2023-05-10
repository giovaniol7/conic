import 'package:brasil_fields/brasil_fields.dart';
import 'package:conic/repositorio/dispositivo_repositorio.dart';
import 'package:conic/view/TelaPrincipal.dart';
import 'package:conic/widgets/campoTexto.dart';
import 'package:conic/widgets/mensagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TelaCadastroDispositivo extends StatefulWidget {
  final int? id;
  const TelaCadastroDispositivo({Key? key, required this.id}) : super(key: key);

  @override
  State<TelaCadastroDispositivo> createState() => _TelaCadastroDispositivoState();
}

class _TelaCadastroDispositivoState extends State<TelaCadastroDispositivo> {
  var txtNome = TextEditingController();
  var txtMAC = TextEditingController();
  late int IdCliente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Cadastro de Dispositivo", style: TextStyle(color: Colors.black),),
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
              campoTexto('Nome do Dispositivos', txtNome, Icons.abc),
              const SizedBox(height: 20),
              campoTexto('MAC', txtMAC, Icons.sd_card),
              const SizedBox(height: 20),
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
                        DispositivoRepositorio DR = new DispositivoRepositorio();
                        DR.Post(widget.id, txtNome.text, txtMAC.text);
                        sucesso(context, 'Dispositivo cadastrado.');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => TelaPrincipal(widget.id)));
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
}

