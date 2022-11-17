class Cliente{

  int? id;
  String? nome;
  String? email;
  String? senha;
  String? telefone1;
  String? telefone2;

  Cliente({this.id, this.nome, this.email, this.senha, this.telefone1, this.telefone2});

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

  int? get getId => id;
  set setId(int value) {
    id = value;
  }

  String? get getNome => nome;
  set setNome(String value) {
    nome = value;
  }

  String? get getSenha => senha;
  set setSenha(String value) {
    senha = value;
  }

  String? get getEmail => email;
  set setEmail(String value) {
    email = value;
  }

  String? get getTelefone1 => telefone1;
  set setTelefone1(String value) {
    telefone1 = value;
  }

  String? get getTelefone2 => telefone2;
  set setTelefone2(String value) {
    telefone2 = value;
  }
}