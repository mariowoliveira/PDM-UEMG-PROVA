import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';

import './componenes/card_artista.dart';

import '../cadastrar_artista/cadastrar_artista_screen.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<ListaArtistas>(

      builder: (_,listaArtista,__){

        return Scaffold(
          backgroundColor: corFundo,
          appBar: AppBar(
            title: Text(
              "Cantores",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white70,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: corPrincipal,
            tooltip: "Adicionar Cantor",
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CadastrarArtistaScreen(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),

          body: ListView.builder(

            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: listaArtista.listaArtista.length,
            itemBuilder: (context,index){

              return CardArtista(artista: listaArtista.listaArtista[index],);

            },

          ),

        );

      },

    );
  }
}
