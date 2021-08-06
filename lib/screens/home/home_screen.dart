import 'package:avaliacaoii/api/login/login.dart';
import 'package:avaliacaoii/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';

import './componenes/card_artista.dart';

import '../cadastrar_artista/cadastrar_artista_screen.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer2<ListaArtistas, Login>(

      builder: (_,listaArtista,login,__){

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
            actions: [
              IconButton(
                onPressed: (){
                  login.sair();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen(),
                    ),
                  );
                },
                tooltip: 'Sair',
                icon: Icon(Icons.exit_to_app,color: Colors.white,),
              ),
              const SizedBox(width: 8,),
            ],
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
