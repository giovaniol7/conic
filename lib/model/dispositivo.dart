import 'dart:convert';

class Dispositivo{

  int? id;
  int? idCliente;
  int? lock;
  String? mac;
  String? nome;

  Dispositivo({this.id, this.idCliente, this.nome, this.mac, this.lock});

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

  int? get getId => id;
  set setId(int value) {
    id = value;
  }

  int? get getIdCliente => idCliente;
  set setIdCliente(int value) {
    idCliente = value;
  }

  String? get getNome => nome;
  set setNome(String value) {
    nome = value;
  }

  String? get getMac => mac;
  set setMac(String value) {
    mac = value;
  }

  int? get getLock => lock;
  set setLock(int value) {
    lock = value;
  }
}