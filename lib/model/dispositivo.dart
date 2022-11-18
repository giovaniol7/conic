import 'dart:convert';

class Dispositivo{

  int? id;
  int? idCliente;
  int? lock;
  String? mac;
  String? nome;

  Dispositivo(this.id, this.idCliente, this.nome, this.mac, this.lock);

  Dispositivo.fromJson(Map<String, dynamic> json){
    id: json["id"];
    idCliente: json["idCliente"];
    nome: json["nome"];
    mac: json["mac"];
    lock: json["lock"];
  }

  Map<String, dynamic> toJson(){
    return {
      "id": this.id,
      "idCliente": this.idCliente,
      "nome": this.nome,
      "mac": this.mac,
      "lock": this.lock,
    };
  }
}