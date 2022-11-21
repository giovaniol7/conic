import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

campoTexto(texto, controller, icone, {senha, numeros, formato}) {
  return TextFormField(
    controller: controller,
    obscureText: senha != null ? true : false,
    style: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w300,
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(icone, color: Colors.black),
      prefixIconColor: Colors.black,
      labelText: texto,
      labelStyle: const TextStyle(color: Colors.black),
      border: const OutlineInputBorder(),
      focusColor: Colors.black,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 0.0,
        ),
      ),
    ),
    keyboardType: numeros == true ? TextInputType.number : TextInputType.text,
    inputFormatters: formato != null ? [
    FilteringTextInputFormatter.digitsOnly,
    formato,
    ] : [],
  );
}