import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

class EditarMusicaScreen extends StatefulWidget {

  final Artista artista;
  final Musica musica;
  EditarMusicaScreen({required this.artista,required this.musica});

  @override
  _EditarMusicaScreenState createState() => _EditarMusicaScreenState();
}

class _EditarMusicaScreenState extends State<EditarMusicaScreen> {

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

    return Consumer2<EditarMusica,ListaMusicas>(

      builder: (_,editarMusica,listaMusicas,__){

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
                "Editar Musica",
              style: TextStyle(
                color: Colors.white70
              ),
            ),

            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: editarMusica.loading?null:()async{

              if(formKey.currentState!.validate()){

                await editarMusica.patchEditarMusica(
                    artista: widget.artista,
                    musica: Musica(
                      id: widget.musica.id,
                      nome: _nomeController.text.isNotEmpty?_nomeController.text:widget.musica.nome,
                      duracao: _duracaoController.text.isNotEmpty?(_duracaoController.text):widget.musica.duracao,
                      estilo: _estiloController.text.isNotEmpty?(_estiloController.text):widget.musica.estilo,
                    ),
                    onSuccess: (text)async{

                      listaMusicas.getListaMusicas(idArtista: widget.artista.id);

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
            backgroundColor: editarMusica.loading?Colors.grey:corPrincipal,
            elevation: editarMusica.loading?0:3,
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
                  if(editarMusica.loading)
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
                          initialValue: widget.musica.nome,
                          keyboardType: TextInputType.datetime,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          onChanged: (text){
                            _nomeController.text = text;
                          },
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
                          initialValue: widget.musica.duracao,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          onChanged: (text){
                            _duracaoController.text = text;
                          },
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
                        TextFormField(
                          initialValue: widget.musica.estilo,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          onChanged: (text){
                            _estiloController.text=text;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Estilo da Musica",
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
