import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class ListaMusicas extends ChangeNotifier{

  Dio dio = Dio();

  List<Musica> listaMusicas = [];

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> getListaMusicas({required String idArtista}) async {

    loading = true;
    listaMusicas.clear();

    try{

      final response = await dio.get(
        api_musicas+idArtista+"/musicas/.json",
      );

      if(response.statusCode == 200){

        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);

        data.forEach((key, value) {
          Musica musica = Musica.fromJson(value,key);
          listaMusicas.add(musica);
        });

      }else{
        listaMusicas.clear();
      }

    }catch(e){
      listaMusicas.clear();
    }

    loading = false;

  }

}