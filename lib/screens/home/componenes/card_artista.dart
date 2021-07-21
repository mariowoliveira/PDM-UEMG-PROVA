import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../api/api.dart';
import '../../../helpers/helpers.dart';
import '../../../models/models.dart';

import '../../musica_screen/musica_screen.dart';
import '../../editar_artista/editar_artista_screen.dart';

class CardArtista extends StatelessWidget {

  final Artista artista;
  CardArtista({required this.artista});

  @override
  Widget build(BuildContext context) {
    return Consumer3<DeletarArtista,ListaMusicas,ListaArtistas>(

      builder: (_,deletarArtista,listaMusicas,listaArtistas,__){

        return GestureDetector(

          onTap: (){

            listaMusicas.getListaMusicas(idArtista: artista.id);

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MusicaScreen(artista: artista,),
              ),
            );
          },

          child: Card(
            elevation: 7,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              color: Colors.white70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    artista.nome,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: corPrincipal,
                    ),
                  ),
                  Row(
                    children: [

                      const SizedBox(width: 6,),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            const SizedBox(height: 6,),

                            Text(
                             'E-mail: '+artista.email,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54
                              ),
                            ),

                            const SizedBox(height: 6,),

                            Text(
                              'Senha:'+artista.senha,
                              style: TextStyle(
                                fontSize: 15,
                                  color: Colors.black54
                              ),
                            ),

                            Row(

                              mainAxisAlignment: MainAxisAlignment.end,

                              children: [

                                IconButton(
                                  onPressed: deletarArtista.loading?null:()async{

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditarArtistaScreen(artista: artista),
                                      ),
                                    );

                                  },
                                  tooltip: "Editar",
                                  icon: Icon(
                                    Icons.edit,
                                    color: corPrincipal,
                                  ),
                                ),

                                IconButton(
                                  onPressed: deletarArtista.loading?null:()async{

                                    await deletarArtista.deleteDeletarArtista(
                                      artista: artista,
                                    );

                                    listaArtistas.getListaArtistas();

                                  },
                                  tooltip: "Deletar",
                                  icon: Icon(
                                    Icons.delete,
                                    color: corPrincipal,
                                  ),
                                ),

                              ],

                            )

                          ],
                        ),
                      ),
                      const SizedBox(width: 6,),
                      Expanded(
                        child: Image.network(
                          artista.imagem,
                          fit: BoxFit.cover,
                          height: 200,
                          width: 200,
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ),
        );

      },

    );
  }

}
