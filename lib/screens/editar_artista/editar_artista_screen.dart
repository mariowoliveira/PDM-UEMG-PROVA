import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

class EditarArtistaScreen extends StatefulWidget {

  final Artista artista;
  EditarArtistaScreen({required this.artista});

  @override
  _EditarArtistaScreenState createState() => _EditarArtistaScreenState();
}

class _EditarArtistaScreenState extends State<EditarArtistaScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _nomeController = TextEditingController();
  final _imagemController = TextEditingController();
  final _emailController = TextEditingController();

  void limparCampos(){
    _nomeController.clear();
    _imagemController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer2<EditarArtista,ListaArtistas>(

      builder: (_,editarArtista,listaJogadores,__){

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Editar Cantor",
              style: TextStyle(
                  color: Colors.white70
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: editarArtista.loading?null:()async{

              if(formKey.currentState!.validate()){

                await editarArtista.patchEditarArtista(
                    artista: Artista(
                      nome: _nomeController.text.isNotEmpty?_nomeController.text:widget.artista.nome,
                      imagem: _imagemController.text.isNotEmpty?(_imagemController.text):widget.artista.imagem,
                      email: _emailController.text.isNotEmpty?_emailController.text:widget.artista.email,
                      senha: "",
                      id: widget.artista.id,
                    ),
                    onSuccess: (text)async{

                      listaJogadores.getListaArtistas();

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
            tooltip: 'Editar Cantor',
            backgroundColor: editarArtista.loading?Colors.grey:corPrincipal,
            elevation: editarArtista.loading?0:3,
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(editarArtista.loading)
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
                          initialValue: widget.artista.senha,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          enabled: false,
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
                            labelText: "Senha",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          initialValue: widget.artista.nome,
                          keyboardType: TextInputType.text,
                          onChanged: (text){
                            _nomeController.text = text;
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
                            labelText: "Nome do Cantor",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          initialValue: widget.artista.imagem,
                          keyboardType: TextInputType.number,
                          onChanged: (text){
                            _imagemController.text = text;
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
                            labelText: "Link da Imagem",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          initialValue: widget.artista.email,
                          keyboardType: TextInputType.text,
                          onChanged: (text){
                            _emailController.text = text;
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
                            labelText: "E-mail",
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
