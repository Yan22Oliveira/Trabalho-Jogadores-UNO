class Jogos{

  String id = "";
  String dataJogo = "";
  String posicao = "";
  int jogadores = 0;

  Jogos({
    required this.id,
    required this.dataJogo,
    required this.posicao,
    required this.jogadores,
  });

  Jogos.fromJson(Map<String, dynamic> json, String key) {
    id = key;
    dataJogo  = json["dataJogo"].toString();
    posicao   = json["posicao"].toString();
    jogadores = json["jogadores"];
  }

}