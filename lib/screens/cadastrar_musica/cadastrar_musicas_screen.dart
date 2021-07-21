import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

class CadastrarMusicasScreen extends StatefulWidget {

  final Artista artista;
  CadastrarMusicasScreen({required this.artista});

  @override
  _CadastrarMusicasScreenState createState() => _CadastrarMusicasScreenState();
}

class _CadastrarMusicasScreenState extends State<CadastrarMusicasScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _nomeController = TextEditingController();
  final _duracaoController = TextEditingController();
  final _estiloController = TextEditingController();

  void limparCampos(){
    _nomeController.clear();
    _duracaoController.clear();
    _estiloController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer2<CadastrarMusica,ListaMusicas>(

      builder: (_,cadastrarJogos,listaJogos,__){

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Cadastrar Musicas",
              style: TextStyle(
                  color: Colors.white70
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: cadastrarJogos.loading?null:()async{

              if(formKey.currentState!.validate()){

                await cadastrarJogos.postCadastrarMusica(
                    artista: widget.artista,
                    musica: Musica(
                      id: "",
                      nome: _nomeController.text,
                      duracao: _duracaoController.text,
                      estilo: (_estiloController.text),
                    ),
                    onSuccess: (text)async{

                      listaJogos.getListaMusicas(idArtista: widget.artista.id);

                      scaffoldKey.currentState!.showSnackBar(
                          SnackBar(
                            content: Text(
                              text,
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          )
                      );

                      Future.delayed(Duration(seconds: 2)).then((_){
                        Navigator.pop(context);
                      });

                    },
                    onFail: (text){
                      scaffoldKey.currentState!.showSnackBar(
                          SnackBar(
                            content: Text(
                              text,
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 3),
                          )
                      );
                    }
                );

              }

            },
            tooltip: 'Salvar Musica',
            backgroundColor: cadastrarJogos.loading?Colors.grey:corPrincipal,
            elevation: cadastrarJogos.loading?0:3,
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(cadastrarJogos.loading)
                    LinearProgressIndicator(
                      color: corPrincipal,
                      backgroundColor: Colors.white,
                      minHeight: 5,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 36,),
                        TextFormField(
                          controller: _nomeController,
                          keyboardType: TextInputType.datetime,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Nome da Música",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          controller: _estiloController,
                          keyboardType: TextInputType.text,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Estilo Musical",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          controller: _duracaoController,
                          keyboardType: TextInputType.text,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Duração",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                      ],
                    ),
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
