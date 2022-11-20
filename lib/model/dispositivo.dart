class Dispositivo{
  int? id;
  int? idCliente;
  int? lock;
  String? mac;
  String? nome;

  Dispositivo({required this.id, required this.idCliente, required this.nome, required this.mac, required this.lock});

  Dispositivo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    idCliente = json['idCliente'];
    lock = json['lock'];
    mac = json['mac'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson(){
    return {
      "id": this.id,
      "idCliente": this.idCliente,
      "lock": this.lock,
      "mac": this.mac,
      "nome": this.nome,
    };
  }
}