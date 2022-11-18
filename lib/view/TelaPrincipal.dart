import 'package:conic/model/dispositivo.dart';
import 'package:conic/repositorio/dispositivo_repositorio.dart';
import 'package:conic/view/TelaCadastroDispositivo.dart';
import 'package:conic/view/TelaPerfil.dart';
import 'package:flutter/material.dart';
import 'package:conic/widgets/mensagem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  List<String> itensMenu = ["Editar Perfil", "Deslogar"];
  List<Widget> widgetList = [];
  DispositivoRepositorio dispositivoRepositorio = new DispositivoRepositorio();

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Editar Perfil":
        return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaPerfil(),
            ));
        break;
      case "Deslogar":
        return deslogarUsuario();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(color: Colors.grey.shade100),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Dispositivos"),
          foregroundColor: Colors.black,
          backgroundColor: Colors.grey.shade300,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: _escolhaMenuItem,
              itemBuilder: (context) {
                return itensMenu.map((String item) {
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: FutureBuilder<List<dynamic>>(
            future: dispositivoRepositorio.recuperarDispositivo(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var lista = snapshot.data;
                      Dispositivo dispositivo = lista![index];
                      return ListTile(
                        title: Text(dispositivo.nome!),
                        subtitle: Text(dispositivo.mac!),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const CircularProgressIndicator();
            },
          ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastroDispositivo(),
                ));
          },
        ),
      ),
    );
  }

  void deslogarUsuario() async {
    sucesso(context, 'O usuário deslogado!');
    Navigator.pushReplacementNamed(context, '/login');
  }

  Widget dismiss(tabela) {
    return Dismissible(
      key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (e) {},
      background: Container(
        color: Colors.red.shade500,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
        ),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage("lib/imagens/dispositivo.png"),
        ),
        title: Text(
          tabela.nome,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          tabela.mac,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.lock_open),
          onPressed: () {},
        ),
        onTap: () {},
      ),
    );
  }
}
