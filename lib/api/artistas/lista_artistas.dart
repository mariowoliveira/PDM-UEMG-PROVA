import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class ListaArtistas extends ChangeNotifier{

  ListaArtistas(){
    getListaArtistas();
  }

  Dio dio = Dio();

  List<Artista> listaArtista = [];

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> getListaArtistas() async {

    loading = true;
    listaArtista.clear();

    try{

      final response = await dio.get(
        api_artistas,
      );

      if(response.statusCode == 200){

        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);

        data.forEach((key, value) {
          Artista artista = Artista.fromJson(value,key);
          listaArtista.add(artista);
        });

      }else{
        listaArtista.clear();
      }

    }catch(e){
      listaArtista.clear();
    }

    loading = false;

  }

}