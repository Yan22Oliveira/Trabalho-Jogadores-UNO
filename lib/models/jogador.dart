class Jogador{

  String id = "";
  String nome = "";
  String contato = "";
  String email = "";
  String senha = "";

  Jogador({
    required this.id,
    required this.nome,
    required this.contato,
    required this.email,
    required this.senha,
  });

  Jogador.fromJson(Map<String, dynamic> json, String key) {
    id = key;
    nome    = json["nome"].toString();
    contato = json["contato"].toString();
    email   = json["email"].toString();
    senha   = json["senha"].toString();
  }

}
