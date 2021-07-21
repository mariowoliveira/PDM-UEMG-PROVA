import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class DeletarMusica extends ChangeNotifier{

  Dio dio = Dio();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> deleteDeletarMusica({
    required Artista artista,
    required Musica musica,
  }) async {

    loading = true;

    try{

      final response = await dio.delete(
        api_musicas+artista.id+"/musicas/"+musica.id+".json",
      );

      if(response.statusCode == 200){

      }

    }catch(e){

    }

    loading = false;

  }

}