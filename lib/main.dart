import 'package:conic/view/TelaLogin.dart';
import 'package:conic/view/TelaPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  int? token;

  WidgetsFlutterBinding.ensureInitialized();
  final tokenSave = await SharedPreferences.getInstance();
  token = tokenSave.getInt('aceite');
  print(token);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'LeakBlocker',
    home:  token == null || token == 0 ? TelaLogin() : TelaPrincipal(token),
  ) );
}
