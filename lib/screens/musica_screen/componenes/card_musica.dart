import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../api/api.dart';
import '../../../helpers/helpers.dart';
import '../../../models/models.dart';

import '../../editar_musica/editar_musica_screen.dart';

class CardMusica extends StatelessWidget {

  final Artista artista;
  final Musica musica;
  CardMusica({required this.artista, required this.musica});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DeletarMusica,ListaMusicas>(

      builder: (_,deletarMusica,listaMusicas,__){

        return GestureDetector(

          onTap: (){


          },

          child: Card(
            elevation: 7,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              color: Colors.white70,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    (musica.nome),
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: corPrincipal,
                    ),
                  ),
                  Row(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [



                          const SizedBox(height: 6,),

                          Text(
                            "Duração: "+musica.duracao,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),

                          const SizedBox(height: 6,),
                          Text(
                            "Estilo: "+musica.estilo,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      IconButton(
                        onPressed: ()async{


                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditarMusicaScreen(
                                artista: artista,
                                musica: musica,
                              ),
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
                        onPressed: deletarMusica.loading?null:()async{
                          await deletarMusica.deleteDeletarMusica(
                            artista: artista,
                            musica: musica,
                          );
                          listaMusicas.getListaMusicas(idArtista: artista.id);

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
          ),
        );

      },

    );
  }

}
