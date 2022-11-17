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

  late List<Dispositivo>? dispositivoModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    dispositivoModel =
        (await dispositivoRepositorio.recuperarDispositivoCliente())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

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
        body: Expanded(
          child: dispositivoModel == null || dispositivoModel!.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: dispositivoModel!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(dispositivoModel![index].id.toString()),
                              Text(dispositivoModel![index].nome),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(dispositivoModel![index].mac),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
