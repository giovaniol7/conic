import 'package:conic/model/dispositivo.dart';
import 'package:conic/repositorio/dispositivo_repositorio.dart';
import 'package:conic/view/TelaCadastroDispositivo.dart';
import 'package:conic/view/TelaEditarDispositivo.dart';
import 'package:conic/view/TelaPerfil.dart';
import 'package:flutter/material.dart';
import 'package:conic/widgets/mensagem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaPrincipal extends StatefulWidget {
  final int? id;
  const TelaPrincipal({Key? key, this.id}) : super(key: key);
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
              builder: (context) => TelaPerfil(id: widget.id),
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
          future: dispositivoRepositorio.recuperarDispositivo(widget.id!),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var lista = snapshot.data;
                    Dispositivo dispositivo = lista![index];
                    return dismiss(dispositivo);
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastroDispositivo(id: widget.id),
                ));
          },
        ),
      ),
    );
  }

  void deslogarUsuario() async {
    sucesso(context, 'O usuário deslogado!');
    saveValor();
    Navigator.pushReplacementNamed(context, '/login');
  }

  Widget dismiss(tabela) {
    return Dismissible(
      key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (e) {
        dispositivoRepositorio.Delete(tabela.id);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => TelaPrincipal(id: widget.id)));
        sucesso(context, 'Dispositivo Apagado.');
      },
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
            icon: tabela.lock == 0 ? const Icon(Icons.lock_open) : const Icon(Icons.lock),
            onPressed: () {
              if (tabela.lock == 1){
            dispositivoRepositorio.Put(tabela.id, tabela.idCliente, tabela.nome, tabela.mac, 0);
            Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => TelaPrincipal(id: widget.id)));
            sucesso(context, 'Dispositivo Liberado.');
          }else if (tabela.lock == 0){
            dispositivoRepositorio.Put(tabela.id, tabela.idCliente, tabela.nome, tabela.mac, 1);
            Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => TelaPrincipal(id: widget.id)));
            sucesso(context, 'Dispositivo Fechado.');
          }
            }),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TelaEditarDispositivo(
                    id: widget.id, macc: tabela.mac, idCliente: widget.id),
              ));
        },
      ),
    );
  }

  void saveValor() async {
    final tokenSave = await SharedPreferences.getInstance();
    await tokenSave.setInt('aceite', 0);
    print(tokenSave);
  }
}
