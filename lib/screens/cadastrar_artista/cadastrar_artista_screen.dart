import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

class CadastrarArtistaScreen extends StatefulWidget {

  @override
  _CadastrarArtistaScreenState createState() => _CadastrarArtistaScreenState();
}

class _CadastrarArtistaScreenState extends State<CadastrarArtistaScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _nomeController = TextEditingController();
  final _imagemController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _senhaSegundaController = TextEditingController();

  void limparCampos(){
    _nomeController.clear();
    _imagemController.clear();
    _emailController.clear();
    _senhaController.clear();
    _senhaSegundaController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer2<CadastrarArtista,ListaArtistas>(

      builder: (_,cadastrarArtista,listaArtistas,__){

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Cadastrar Cantor",
              style: TextStyle(
                  color: Colors.white70
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: cadastrarArtista.loading?null:()async{

              if(formKey.currentState!.validate()){

                if(compararSenhas(
                    senha: _senhaController.text,
                    segundaSenha: _senhaSegundaController.text,
                  )
                ){

                  await cadastrarArtista.postCadastrarArtista(
                      artista: Artista(
                        nome: _nomeController.text,
                        imagem: _imagemController.text,
                        email: _emailController.text,
                        senha: _senhaController.text,
                        id: "",
                      ),
                      onSuccess: (text)async{

                        listaArtistas.getListaArtistas();

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

                }else{
                  scaffoldKey.currentState!.showSnackBar(
                      SnackBar(
                        content: Text(
                          "Senhas não coferem",
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.redAccent,
                        duration: Duration(seconds: 3),
                      )
                  );
                }

              }

            },
            tooltip: 'Salvar Cantor',
            backgroundColor: cadastrarArtista.loading?Colors.grey:corPrincipal,
            elevation: cadastrarArtista.loading?0:3,
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
                  if(cadastrarArtista.loading)
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
                            labelText: "Nome do Cantor",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          controller: _imagemController,
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
                            labelText: "Link da Imagem",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.text,
                          validator: (email){
                            if(email!.isEmpty)
                              return 'Campo obrigatório';
                            else if(!emailValid(email))
                              return 'E-mail inválido';
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
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          controller: _senhaController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          obscureText: true,
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
                          controller: _senhaSegundaController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          obscureText: true,
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
                            labelText: "Confirme a Senha",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
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
