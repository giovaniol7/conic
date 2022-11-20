import 'package:conic/view/TelaCadastroDispositivo.dart';
import 'package:conic/view/TelaPerfil.dart';
import 'package:flutter/material.dart';
import 'package:conic/view/TelaLogin.dart';
import 'package:conic/view/TelaPrincipal.dart';
import 'package:conic/view/TelaCadastroUsuario.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  String? token;
  verificar () async {

  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sensor de Gás',
      initialRoute: '/login', //token == null || token == '' ? '/login' : '/principal',
      routes: {
        '/login': (context) => const TelaLogin(),
        '/usuario': (context) => const TelaCadastroUsuario(),
      },
    );
  }
}
