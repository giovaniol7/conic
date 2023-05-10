import 'package:brasil_fields/brasil_fields.dart';
import 'package:conic/model/dispositivo.dart';
import 'package:conic/repositorio/dispositivo_repositorio.dart';
import 'package:conic/view/TelaPrincipal.dart';
import 'package:conic/widgets/campoTexto.dart';
import 'package:conic/widgets/mensagem.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TelaEditarDispositivo extends StatefulWidget {
  final int? id;
  final String? macc;
  final int? idCliente;
  const TelaEditarDispositivo({Key? key, required this.id, required this.macc, required this.idCliente}) : super(key: key);

  @override
  State<TelaEditarDispositivo> createState() => _TelaEditarDispositivoState();
}

class _TelaEditarDispositivoState extends State<TelaEditarDispositivo> {
  var txtNome = TextEditingController();
  var txtMAC = TextEditingController();
  late int IdCliente;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperarDispositivoID(widget.macc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Atualizar Dispositivo", style: TextStyle(color: Colors.black),),
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
                      child: const Text('Atualizar'),
                      onPressed: () {
                        DispositivoRepositorio DR = new DispositivoRepositorio();
                        DR.Put(widget.id, widget.idCliente, txtNome.text, txtMAC.text, 0);
                        sucesso(context, 'Dispositivo atualizado.');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => TelaPrincipal(widget.id)));
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

  recuperarDispositivoID(macc) async {
    DispositivoRepositorio dispositivoRepositorio = DispositivoRepositorio();
    Dispositivo c = await dispositivoRepositorio.recuperarDispositivoMAC(macc);
    var id = c.id;
    txtNome.text = c.nome!;
    txtMAC.text = c.mac!;
  }
}

