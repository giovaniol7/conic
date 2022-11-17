import 'dart:convert';

List<Dispositivo> userModelFromJson(String str) =>
    List<Dispositivo>.from(json.decode(str).map((x) => Dispositivo.fromJson(x)));

class Dispositivo{

  int? id;
  int idCliente;
  String nome;
  String mac;
  int lock;

  Dispositivo({required this.id, required this.idCliente, required this.nome, required this.mac, required this.lock});

  factory Dispositivo.fromJson(Map<String, dynamic> json) => Dispositivo(
    id: json["id"],
    idCliente: json["idCliente"],
    nome: json["nome"],
    mac: json["mac"],
    lock: json["lock"],
  );

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

  int get getIdCliente => idCliente;
  set setIdCliente(int value) {
    idCliente = value;
  }

  String get getNome => nome;
  set setNome(String value) {
    nome = value;
  }

  String get getMac => mac;
  set setMac(String value) {
    mac = value;
  }

  int get getLock => lock;
  set setLock(int value) {
    lock = value;
  }
}