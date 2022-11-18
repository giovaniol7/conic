class Cliente{

  int? id;
  String? nome;
  String? email;
  String? senha;
  String? telefone1;
  String? telefone2;

  Cliente(this.id, this.nome, this.email, this.senha, this.telefone1, this.telefone2);

  Cliente.fromJson(Map<String, dynamic> json){
    id: json["id"];
    nome: json["nome"];
    email: json["email"];
    senha: json["senha"];
    telefone1: json["telefone1"];
    telefone2: json["telefone2"];
  }

  Map<String, dynamic> toJson(){
    return {
      "id": this.id,
      "nome": this.nome,
      "email": this.email,
      "senha": this.senha,
      "telefone1": this.telefone1,
      "telefone2": this.telefone2
    };
  }
}