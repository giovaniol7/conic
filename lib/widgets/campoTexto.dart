import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

campoTexto(texto, controller, icone,
    {senha, sufIcon, numeros, formato, maxPalavras, maxLinhas, tamanho, validator}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black),
        color: Colors.white,
        boxShadow: [
          BoxShadow(offset: Offset(0, 3), color: Colors.grey, blurRadius: 5) // changes position of shadow
        ]
    ),
    child: TextFormField(
      controller: controller,
      obscureText: senha == true ? true : false,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        contentPadding:
        EdgeInsets.symmetric(vertical: tamanho == null ? 20 : tamanho),
        suffixIcon: sufIcon,
        prefixIcon: Icon(icone, color: Colors.black),
        prefixIconColor: Colors.black,
        labelText: texto,
        labelStyle:
        const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        border: const OutlineInputBorder(),
        focusColor: Colors.grey[100],
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
      keyboardType: numeros == true ? TextInputType.number : TextInputType.text,
      inputFormatters: formato != null
          ? [
        FilteringTextInputFormatter.digitsOnly,
        formato,
      ]
          : [],
      maxLength: maxPalavras,
      maxLines: maxLinhas == null ? 1 : maxLinhas,
      validator: validator,
      onSaved: (val) => controller = val,
    ),
  );
}
