class Artista{

  String id = "";
  String nome = "";
  String imagem = "";
  String email = "";
  String senha = "";

  Artista({
    required this.id,
    required this.nome,
    required this.imagem,
    required this.email,
    required this.senha,
  });

  Artista.fromJson(Map<String, dynamic> json, String key) {
    id = key;
    nome    = json["nome"].toString();
    imagem  = json["imagem"].toString();
    email   = json["email"].toString();
    senha   = json["senha"].toString();
  }

}
