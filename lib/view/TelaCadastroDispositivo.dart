import 'package:brasil_fields/brasil_fields.dart';
import 'package:conic/repositorio/dispositivo_repositorio.dart';
import 'package:conic/widgets/campoTexto.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TelaCadastroDispositivo extends StatefulWidget {
  const TelaCadastroDispositivo({Key? key}) : super(key: key);

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
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Criar'),
                      onPressed: () {
                        DispositivoRepositorio DR = new DispositivoRepositorio();
                        DR.Post(IdCliente, txtNome.text, txtMAC.text);
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

