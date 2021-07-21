class Musica{

  String id = "";
  String nome    = "";
  String duracao = "";
  String estilo  = "";

  Musica({
    required this.id,
    required this.nome,
    required this.duracao,
    required this.estilo,
  });

  Musica.fromJson(Map<String, dynamic> json, String key) {
    id = key;
    nome     = json["nome"].toString();
    duracao  = json["duracao"].toString();
    estilo   = json["estilo"];
  }

}